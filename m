Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7BBC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B6C20879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B6C20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTT3g-0002zi-FZ
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:21:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTT17-0001Df-9N
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTT15-0005I7-7G
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:18:57 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTT12-00056K-Vn; Wed, 22 May 2019 11:18:53 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1N1feo-1gW6552dp2-011zoX; Wed, 22 May 2019 17:18:19 +0200
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190517183246.11933-1-armbru@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <33d15cc3-b0f5-a6c4-8bc5-e1c670128730@vivier.eu>
Date: Wed, 22 May 2019 17:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190517183246.11933-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lrzMmUhrUwLu457iIHmgfe0z60/6eFBn03T//p8gZKoOI1VMYoJ
	IqAUWNbVFeoyFG8nbbgW6+2iTOFkNMVnTuMjny/o/mVDkueCLrdoGaLny2263PVv96+yO6W
	KUqMKvyDZ15hnLCJ+gHkA6Y50x+1f5U7oAhH7Ja65ydy2FRyPA1DHVbT8nOU3L6fL/XN7Ks
	FkdhF+EbXDxUp53s4aghA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ToSxrjwBL5A=:t90TElZc3KvASfGls6oaiY
	dL2puFu5I/6/YC1XyygjN7c+IKYd9BAcceTFRAWzmW+/jJbFrH0VFnA326a84aSSgEGu3PVdP
	G9uM+TN20KXq3R8wA5e85jckBbAqZvGKYmTQQP0ig9SqMExNnIaO3BeefwGFdQKPG4gAd8+n+
	9gwRMVOEPejCrgyS8WxaOPSpWWsleso74IRX+eq471I9LED0I+fgWjMDiu3RSfH2/0UmyLluC
	UGpAb8GS2PX+Nqa7v4/wayROEJg0MAdj+EEiXA+1Hk0V/Muuk99ijR4ea/ZqIwHI0sNbzd+NX
	gr1Ubh4gr4+L5xNkcj8EcMS0FFHtPfhpfG8DwXabLYtx6VErLvMuwiqMdb/G/zX/p8jeTf5Cm
	VirhoULIlSPY20mrIwDiV8+Zj1RZ6Mp9PvQkMJF6NEB/Brq3zQbmwi8e87k3kZBz8VPgI/1eZ
	Q9mXaXj4LjQpp7LoKFDLV8s/4sp/Yi1cOwlzDIpirDcL3d9aKeuo/OfPJJerMdoRcgQTEJldt
	ww6vKKZ2dtJoc1NOwry9dy/ECayOn6QLsgmrtwRfF0DHmWu6PJgpjz8D4Nhxyq519SHeqlI1K
	4RufF3teNppunlc/QdckmBkO7utjc4ugEU94Atqs34g+UM2ulLM2Ed7PTsa+dbRTyRl5ZJasP
	Hqb66CIapZ5/4oSJ0/lZHv9LOvL2Uv7vVLrwCZm5HYWJafuyVg7+b8dL3httRCj9VSnnrTEdz
	s/1t47MypHqzyuJ1p2/9QwNbDabu7ZCWSU6SeMTBwTBDlvdM7lewdkFVzNI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] configure: Fix spelling of
 sdl-image in --help
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/05/2019 20:32, Markus Armbruster wrote:
> Fixes: a442fe2f2b2f20e7be0934277e9400b844b11999
> Cc: qemu-trivial@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index d2fc346302..cef51b2a0b 100755
> --- a/configure
> +++ b/configure
> @@ -1745,7 +1745,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>     gcrypt          libgcrypt cryptography support
>     auth-pam        PAM access control
>     sdl             SDL UI
> -  sdl_image       SDL Image support for icons
> +  sdl-image       SDL Image support for icons
>     gtk             gtk UI
>     vte             vte support for the gtk UI
>     curses          curses UI
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

