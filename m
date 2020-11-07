Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F24EC388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 06:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D52B206FA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 06:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="AkjWQmzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D52B206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=comstyle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbHOL-00066x-Fg
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 01:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1kbHNl-0005fq-OW
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 01:07:25 -0500
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]:16469
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1kbHNk-0005Ca-1X
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 01:07:25 -0500
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4CSmzD6yTrz8PbN;
 Sat,  7 Nov 2020 01:08:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=comstyle.com; h=subject
 :from:to:cc:references:message-id:date:mime-version:in-reply-to
 :content-type:content-transfer-encoding; s=default; bh=Y0NXrG9Gw
 qO+0qDOIib5tbtp83Y=; b=AkjWQmzSTaaNza+H58i6mzTsvrq76STCHzHQLEw9P
 1nEQtgqLeOkjsP3Ts24/Fq4llNBjfI1lFDOZnojXXOesZc8cPNJd1TpyS0OxcZm7
 L4K1GPqbuZtvfziZpE1EohthDLflFfnuSGBAD1vypaLYE9L9ugDG/geAsuAQAObI
 Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=subject:from
 :to:cc:references:message-id:date:mime-version:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=oIx
 nhUKFfHd1zFh+2iD+YYsT3gf6pbqvPI9SxO2r92RIy6HCZbKLlHR5ZzV2eNDzkZj
 6gWx7YkS43Qp7YeHZon+v3gYvy3Vr6rxfyacRmD0/U/sJRwdh+mdY68qpYchYtmR
 2vFeTeDpHX0xyW4e0xAkHBAyd608y7B8+pgUfkYc=
Received: from [192.168.6.30]
 (bras-base-toroon2719w-grc-36-142-114-120-158.dsl.bell.ca [142.114.120.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4CSmzD5x4qz8PbK;
 Sat,  7 Nov 2020 01:08:40 -0500 (EST)
Subject: Re: [PATCH] tests/vm: update openbsd to release 6.8
From: Brad Smith <brad@comstyle.com>
To: Philippe Mathieu-Daud?? <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
References: <20201027053048.GB64546@humpty.home.comstyle.com>
 <cbae54c3-fa97-19e6-512c-7ac570f56b12@redhat.com>
 <20201027102245.GC64546@humpty.home.comstyle.com>
Message-ID: <2f27fba1-d5e6-6734-e608-36406e6fe00a@comstyle.com>
Date: Sat, 7 Nov 2020 01:07:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201027102245.GC64546@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping.

On 10/27/2020 6:22 AM, Brad Smith wrote:
> On Tue, Oct 27, 2020 at 11:05:20AM +0100, Philippe Mathieu-Daud?? wrote=
:
>> On 10/27/20 6:30 AM, Brad Smith wrote:
>>> tests/vm: update openbsd to release 6.8
>>>
>>> A double dash at the end of a package name removes ambiguity
>>> when the intent is to install a non-FLAVORed package.
>>>
>>> Signed-off-by: Brad Smith <brad@comstyle.com>
>>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>>> Tested-by: Gerd Hoffmann <kraxel@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daud?? <philmd@redhat.com>
>> I confirm Brad sent us this patch off-list, and
>> - our review comments are addressed,
>> - the tags are correct.
>>
>> The patch format itself seems broken... Like a copy/paste
>> into an email client...
> Well, git diff vs a format-patch.
>
>
> Subject: [PATCH] tests/vm: update openbsd to release 6.8
>
> A double dash at the end of a package name removes ambiguity
> when the intent is to install a non-FLAVORed package.
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/vm/openbsd | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 8356646f21..5ffa4f1b37 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
>       name =3D "openbsd"
>       arch =3D "x86_64"
>  =20
> -    link =3D "https://cdn.openbsd.org/pub/OpenBSD/6.6/amd64/install66.=
iso"
> -    csum =3D "b22e63df56e6266de6bbeed8e9be0fbe9ee2291551c5bc03f3cc2e4a=
b9436ee3"
> +    link =3D "https://cdn.openbsd.org/pub/OpenBSD/6.8/amd64/install68.=
iso"
> +    csum =3D "47e291fcc2d0c1a8ae0b66329f040b33af755b6adbd21739e20bb5ad=
56f62b6c"
>       size =3D "20G"
>       pkgs =3D [
>           # tools
> @@ -36,10 +36,10 @@ class OpenBSDVM(basevm.BaseVM):
>           "bash",
>           "gmake",
>           "gsed",
> -        "gettext",
> +        "gettext-tools",
>  =20
>           # libs: usb
> -        "libusb1",
> +        "libusb1--",
>  =20
>           # libs: crypto
>           "gnutls",

