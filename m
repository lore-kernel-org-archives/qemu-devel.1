Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC67BC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318452220D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWwVzbWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318452220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6ct-0000s1-7i
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kL6X7-0002Eg-TE
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kL6X5-0004oi-6U
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600874288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HqIL6f9jCxFn9/51dPcCr4LHPHEretPTZzT8MDT+X9k=;
 b=CWwVzbWtkNHevUH1n2LJNShewkEjJrFvKVVaNrRWzBEKW0BfbJN1/adih65NPcqaQYQfoj
 +yytwl6xnw5XZa4kHAjeVnDXSno9BRO/hLX419aQl/QhyG4qtE6FIauvF8W3SqbShpbfD9
 F6mvKfxWEIfNOKzz5SZIsHdU5OFVMuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-OQJC_lmOOCS5FkgSarRK7A-1; Wed, 23 Sep 2020 11:17:49 -0400
X-MC-Unique: OQJC_lmOOCS5FkgSarRK7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DA2DAE821;
 Wed, 23 Sep 2020 15:17:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A3287368A;
 Wed, 23 Sep 2020 15:17:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C6F441132E9A; Wed, 23 Sep 2020 17:17:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 3/3] qemu-options: document SMBIOS type 11 settings
References: <20200923133804.2089190-1-berrange@redhat.com>
 <20200923133804.2089190-4-berrange@redhat.com>
Date: Wed, 23 Sep 2020 17:17:43 +0200
In-Reply-To: <20200923133804.2089190-4-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 23 Sep 2020 14:38:04
 +0100")
Message-ID: <87sgb834ko.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NUMERIC_HTTP_ADDR=1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qemu-options.hx | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 47f64be0c0..2cb034bce3 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2296,6 +2296,8 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
>      "-smbios type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Ds=
tr][,serial=3Dstr]\n"
>      "              [,asset=3Dstr][,part=3Dstr][,max-speed=3D%d][,current=
-speed=3D%d]\n"
>      "                specify SMBIOS type 4 fields\n"
> +    "-smbios type=3D11[,value=3Dstr][,path=3Dfilename]\n"
> +    "                specify SMBIOS type 11 fields\n"
>      "-smbios type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3Dstr]=
[,serial=3Dstr]\n"
>      "               [,asset=3Dstr][,part=3Dstr][,speed=3D%d]\n"
>      "                specify SMBIOS type 17 fields\n",
> @@ -2319,6 +2321,45 @@ SRST
>  ``-smbios type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Dstr]=
[,serial=3Dstr][,asset=3Dstr][,part=3Dstr]``
>      Specify SMBIOS type 4 fields
> =20
> +``-smbios type=3D11[,value=3Dstr][,path=3Dfilename]``
> +    Specify SMBIOS type 11 fields inline

"inline"?

> +
> +    This argument can be repeated multiple times, and values are added i=
n the order they are parsed.
> +    Applications intending to use OEM strings data are encouraged to use=
 their application name as
> +    a prefix for the value string. This facilitates passing information =
for multiple applications
> +    concurrently.
> +
> +    The ``value=3Dstr`` syntax provides the string data inline, while th=
e ``path=3Dfilename`` syntax
> +    loads data from a file on disk. Note that the file is not permitted =
to contain any NUL bytes.

Out of curiosity: what happens when it does?

> +
> +    Both the ``value`` and ``path`` options can be repeated multiple tim=
es and will be added to
> +    the SMBIOS table in the order in which they appear.
> +
> +    Note that on the x86 architecture, the total size of all SMBIOS tabl=
es is limited to 65535
> +    bytes. Thus the OEM strings data is not suitable for passing large a=
mounts of data into the
> +    guest. Instead it should be used as a indicator to inform the guest =
where to locate the real
> +    data set, for example, by specifying the serial ID of a block device=
.
> +
> +    An example passing three strings is
> +
> +    .. parsed-literal::
> +
> +        -smbios type=3D11,value=3Dcloud-init:ds=3Dnocloud-net;s=3Dhttp:/=
/10.10.0.1:8000/,\\
> +                        value=3Danaconda:method=3Dhttp://dl.fedoraprojec=
t.org/pub/fedora/linux/releases/25/x86_64/os,\\
> +                        path=3D/some/file/with/oemstringsdata.txt
> +
> +    In the guest OS this is visible with the ``dmidecode`` command
> +
> +     .. parsed-literal::
> +
> +         $ dmidecode -t 11
> +         Handle 0x0E00, DMI type 11, 5 bytes
> +         OEM Strings
> +              String 1: cloud-init:ds=3Dnocloud-net;s=3Dhttp://10.10.0.1=
:8000/
> +              String 2: anaconda:method=3Dhttp://dl.fedoraproject.org/pu=
b/fedora/linux/releases/25/x86_64/os
> +              String 3: myapp:some extra data
> +
> +
>  ``-smbios type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3Dstr][,s=
erial=3Dstr][,asset=3Dstr][,part=3Dstr][,speed=3D%d]``
>      Specify SMBIOS type 17 fields
>  ERST


