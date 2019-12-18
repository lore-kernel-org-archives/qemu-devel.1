Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12157C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1496206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoZodbjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1496206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iheO0-0001dz-Uj
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 13:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iheMz-0001CH-Ru
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iheMw-0006SZ-Ii
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:48:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47373
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iheMv-0006Md-PS
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576694900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=ZyLY1V/XSm/85nOtfJgkYFkV/HEIumILP3PMWFxTOTs=;
 b=XoZodbjDAJTeuZ/gEYI5zw4SPeFz7dQax3Q5ffUWBbpYh2kAiTe2k74unBVi+tRjL3wkln
 JcCp2mkFQnn+xBaK4B74NRORXParRTjIUPO52/r4jN1DGCIK7J8nsqEwI911Kb1BAVHAnh
 TRXu2Uhx8uMIDKemZ1D7VltT0VwfPeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-_h4pyBXLNCm3frxdzmfoBA-1; Wed, 18 Dec 2019 13:48:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C36D29113B
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 18:48:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-120.ams2.redhat.com [10.36.116.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6873E7D991;
 Wed, 18 Dec 2019 18:48:11 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] tests/acceptance: avocado_qemu: Introduce the
 'accel' test parameter
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20191218170003.31356-1-wainersm@redhat.com>
 <20191218170003.31356-2-wainersm@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a95fe33b-2767-4e43-0a0e-424b90446623@redhat.com>
Date: Wed, 18 Dec 2019 19:48:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218170003.31356-2-wainersm@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _h4pyBXLNCm3frxdzmfoBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: philmd@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/2019 18.00, Wainer dos Santos Moschetta wrote:
> The test case may need to boot the VM with an accelerator that
> isn't actually enabled on the QEMU binary and/or present in the host. In
> this case the test behavior is undefined, and the best course of
> action is to skip its execution.
> 
> This change introduced the 'accel' parameter (and the handler of
> tag with same name) used to indicate the test case requires a
> given accelerator available. It was implemented a mechanism to
> skip the test case if the accelerator is not available. Moreover,
>  the QEMU --accel argument is set automatically to any VM
> launched if the parameter is present.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  docs/devel/testing.rst                    | 16 ++++++++++++++++
>  tests/acceptance/avocado_qemu/__init__.py | 23 +++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 27f286858a..6c2e0718e1 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -757,6 +757,17 @@ name.  If one is not given explicitly, it will either be set to
>  ``None``, or, if the test is tagged with one (and only one)
>  ``:avocado: tags=machine:VALUE`` tag, it will be set to ``VALUE``.
>  
> +accel
> +~~~~~
> +The accelerator that will be set to all QEMUMachine instances created
> +by the test.
> +
> +The ``accel`` attribute will be set to the test parameter of the same
> +name.  If one is not given explicitly, it will either be set to
> +``None``, or, if the test is tagged with one (and only one)
> +``:avocado: tags=accel:VALUE`` tag, it will be set to ``VALUE``. Currently
> +``VALUE`` should be either ``kvm`` or ``tcg``.
> +
>  qemu_bin
>  ~~~~~~~~
>  
> @@ -798,6 +809,11 @@ machine
>  The machine type that will be set to all QEMUMachine instances created
>  by the test.
>  
> +accel
> +~~~~~
> +The accelerator that will be set to all QEMUMachine instances created
> +by the test. In case the accelerator is not available (both QEMU
> +binary and the host system are checked) then the test is canceled.
>  
>  qemu_bin
>  ~~~~~~~~
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index 6618ea67c1..aff32668d9 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -20,6 +20,7 @@ SRC_ROOT_DIR = os.path.join(os.path.dirname(__file__), '..', '..', '..')
>  sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
>  
>  from qemu.machine import QEMUMachine
> +from qemu.accel import kvm_available, tcg_available
>  
>  def is_readable_executable_file(path):
>      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
> @@ -111,6 +112,8 @@ class Test(avocado.Test):
>  
>      def setUp(self):
>          self._vms = {}
> +        # VM argumments that are mapped from parameters
> +        self._param_to_vm_args = []
>  
>          self.arch = self.params.get('arch',
>                                      default=self._get_unique_tag_val('arch'))
> @@ -124,10 +127,30 @@ class Test(avocado.Test):
>          if self.qemu_bin is None:
>              self.cancel("No QEMU binary defined or found in the source tree")
>  
> +        self.accel = self.params.get('accel',
> +                                     default=self._get_unique_tag_val('accel'))
> +        if self.accel:
> +            avail = False
> +            if self.accel == 'kvm':
> +                if kvm_available(self.arch, self.qemu_bin):
> +                    self._param_to_vm_args.append('-enable-kvm')

Could you please use "-accel kvm" instead? "-accel" is now our official
way to configure an accelerator ... so we should not use the old
wrappers in new code anymore if possible.

 Thanks,
  Thomas


PS: Travis supports KVM now, too (with some tweaking of the permissions)
... maybe we should now try to get some QEMU tests running with KVM
there, too...


