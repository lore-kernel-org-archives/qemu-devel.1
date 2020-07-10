Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08856C433EA
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C2E207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeYrru22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C2E207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jttiw-0007QH-Ie
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 10:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jttiM-0006zZ-VQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:09:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25789
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jttiK-0002cc-Nz
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594390159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=b8IplAEy4FIaguh6onZv0BQUkrNKKhOIHVH5n8w+9cU=;
 b=VeYrru22uenAqQzNVDUu+iuuyhm3vyXC/YrO9MDzEKqxLmpaumRzwOBjtkBoUzpdBKujYO
 FsgL093ubhC/fCpzwNHZnmTHSiIz/XIAd1+odtouQpRN30G3LgVTJGcIwPNIAR7nA3yd9d
 m6JOlPOXyMWT0E4JEEX2v1IWtNNlmVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-XZfPmdlUM_iYVARryFma1Q-1; Fri, 10 Jul 2020 10:09:17 -0400
X-MC-Unique: XZfPmdlUM_iYVARryFma1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 091AE19253CB;
 Fri, 10 Jul 2020 14:09:16 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-68.ams2.redhat.com [10.36.112.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5650E7848E;
 Fri, 10 Jul 2020 14:08:55 +0000 (UTC)
Subject: Re: [PATCH v2] Remove the CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE switch
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200710045515.25986-1-thuth@redhat.com>
 <CAFEAcA8vdzu0Td320VxOFHM9+Q3oxQ0ER9-FF4iOS+GsGuc=Zg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <62455702-cda7-9918-1dca-92f7644fc82e@redhat.com>
Date: Fri, 10 Jul 2020 16:08:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8vdzu0Td320VxOFHM9+Q3oxQ0ER9-FF4iOS+GsGuc=Zg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/2020 15.25, Peter Maydell wrote:
> On Fri, 10 Jul 2020 at 05:56, Thomas Huth <thuth@redhat.com> wrote:
>>
>> GCC supports "#pragma GCC diagnostic" since version 4.6, and
>> Clang seems to support it, too, since its early versions 3.x.
>> That means that our minimum required compiler versions all support
>> this pragma already and we can remove the test from configure and
>> all the related #ifdefs in the code.
>>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2: Keep the !defined(__clang__) in coroutine-ucontext.c
> 
> If we're going to mandate "at least gcc 4.6 or clang", perhaps
> we should have a sanity check for it, something like
> 
> #if !defined __clang__
> # if !QEMU_GNUC_PREREQ(4, 6)
> #  error QEMU requires at least GCC 4.6
> # endif
> #endif
> 
> (maybe also check clang version, though that is more awkward
> because upstream clang and Apple's compiler set the version
> number defines differently.)
> 
> We could put that in compiler.h. Checking in configure would be
> more userfriendly but maybe a little more effort.
> The other advantage of this check is we have effectively
> some internal documentation of our current minimum
> compiler requirement.

It's already there. Look for:

 "You need at least GCC v4.8 or Clang v3.4 (or XCode Clang v5.1)"

in the configure script.

> There is also some tidying up that can then be done:
> several places in the code use QEMU_GNU_PREREQ() to insist
> on "at least gcc 4.4" or "at least gcc 4.6",
Oh, weird, I thought we got rid of all of them when we bumped the
minimum requirement to GCC 4.8 ... these spots could certainly be
cleaned up nowadays.

 Thomas


