Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4315BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09657206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCGdvqp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09657206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnk3H-00054M-7M
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnjzr-0000C3-Sr
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:33:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:53842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnjzp-0006zN-R4
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:33:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id j18so3190375wmi.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GmJJzNcIvIb2p/+MkDt2IkLQS7EdJcXX08SQq+h1p/o=;
 b=HCGdvqp5sKloBCJt2sWaqc3IxVf+OYAUXBBByf4IUTXgk0EZgmVnE4MLzc4SxrUNV6
 ff5uL9g+fDBGulQeBZy43edSaq6c+mpJTF2z/j2J4xn88ohiUyAmeGEJ63RvO9SUhx3Q
 cO9VPHOhjZJGrXycxut9Xl859QMxyKsg3edxg+enS2lW+/g9otpD2JhkDCmOamNh2ShK
 3KBHayWibx72xI/jJZ80r3YzTKThk1prGTqgisQBECHW4uWcGzCriQdsrEUfwCx6kh0J
 CltQQPueGLXdFbTFheqHLhfFOfw2NMaGzMOMSVQ56KEQ1GZZb8T4a7OKugo7UXhu2eao
 juKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GmJJzNcIvIb2p/+MkDt2IkLQS7EdJcXX08SQq+h1p/o=;
 b=KMerGuCCDV3kr8Ysx9+Hoi3IVNiDKXXZ1lLko2/Gf2ws7zyDahU1okRulGxrLTqt5+
 1qFuTx91t5je/3bSHgFwwGcq804lDuYXemBBMuDTUtoZfzHlLVGi7ZeVgADKp9HsOysD
 EAw83u3mcZISF2Gp3+AHGMFrFHdPbE7uAjwNwq/9mQnHVmUMe6ZCy83g80NkkctQxWnX
 HQaP2oHwohy3uWaz9vab7fznDsQyp73kMSceao8TW7g2Oan8b71x7Yl70lEOR089hiDU
 kdyKmjorwpP+ISsvn0RS0uV7NgPMJQYi4Gxpf08CKNKyNSoYEGcyf/SeIToyolXzP2Wz
 7cXA==
X-Gm-Message-State: AOAM532Z/1uhZeq+c+z0r90FB78NdlcZWoCBi52zZHseL9GQHFJKVyxc
 DjyK7fmn8APiM//2nFrbBS4=
X-Google-Smtp-Source: ABdhPJzQJQJU1ZPfjoHsOBaXsmBKphdr1xAZjQy2exsIyBDGzrSpJ/X/jjCDs7g+cKgehvlHqZ7/Lg==
X-Received: by 2002:a1c:2b86:: with SMTP id r128mr25790192wmr.13.1592922836154; 
 Tue, 23 Jun 2020 07:33:56 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id j24sm20909380wrd.43.2020.06.23.07.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 07:33:54 -0700 (PDT)
Date: Tue, 23 Jun 2020 15:33:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Dario Ciriminna <dario@ciriminna.com>
Subject: Re: qemu win10 host winxp quest very slow
Message-ID: <20200623143353.GO36568@stefanha-x1.localdomain>
References: <127ef1aa-bcb3-835d-21ba-0918bb62b0f8@ciriminna.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/UvyDgxjlFfP/4zZ"
Content-Disposition: inline
In-Reply-To: <127ef1aa-bcb3-835d-21ba-0918bb62b0f8@ciriminna.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/UvyDgxjlFfP/4zZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 11:03:40AM +0200, Dario Ciriminna wrote:
> Hello folks,
>=20
> i need to compile and run qemu under Windows 10 host (Pentium G860, very
> bad)=A0 with a Windows XP guest.
> Precompiled downloaded binary run smoothly, but my compiled version is ve=
ry
> very slow (I NEED to compile it).
>=20
> I start it with :
>=20
> "C:\Program Files\qemu\qemu-system-x86_64w.exe" .\WindowsXP.img -m 1024M
> -usb -vga std -netdev user,id=3Dn0 -device rtl8139,netdev=3Dn0 -fda
> .\ZSK_DSK.img -D .\qemu.log
>=20
> ah and -D .\qemu.log doesn't log nothing. 0k log file.
>=20
> What can i try ? 3 min to start Windows XP is unacceptable and after start
> system run slow!

According to this page the G860 has virtualization support:
https://ark.intel.com/content/www/us/en/ark/products/53492/intel-pentium-pr=
ocessor-g860-3m-cache-3-00-ghz.html

Did you build with ./configure --enable-whpx for hardware assisted
virtualization support?

If you cannot use WHPX then you may be stuck with the current speed.

Stefan

--/UvyDgxjlFfP/4zZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7yEtEACgkQnKSrs4Gr
c8gDSwgAnbuM4w+INhJmO6Hf0pi0yqa/ck8Sc+nmMbH+kbIrYayJL3HRcUWjSlF+
FvI1pWbucnOzeFKclJitMSFnSbWgbLi5GB7/KFJ9FayepmU8HH1jjzxwLiypN+TY
9IICnIDvBrHAGmfIS7Hj+qblNIQAzGyIIj3iRnxhkzMY/KGZGUWRUMT+ykrOAyTT
3bLlckQseYE1/xEbv6bYr91i3tTPDH/iWuIZEHEej0TOMun8qy7giJ272qF3OFrH
Mg3iaMmrRc2TeC+jyF1HkegsDPtdzGe1gM1AudKmskrsJtej/0tjBZuPEC+8azc/
RRCPvjq8d1F4Xokg5m+1muWm+yCBiQ==
=dp0e
-----END PGP SIGNATURE-----

--/UvyDgxjlFfP/4zZ--

