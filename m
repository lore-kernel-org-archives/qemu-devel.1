Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59250C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A0C2098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlyMbUIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A0C2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVQP-0006nK-FP
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlVMb-00033C-SF
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:32:13 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlVMZ-00007K-Qm
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:32:13 -0400
Received: by mail-wr1-x42a.google.com with SMTP id l11so1791403wru.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 03:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=a7dqyj5cuUATWqNomX1lzd1a0dS44usP0OrTroPvyR8=;
 b=qlyMbUIM8UHbamdlsDM1TkzEyVL8t5aAB979Cnd4MbV7ZkAOZzdsvWBXN23A4eFPxW
 3wv62jhvE7J5bRcfR3OiKZ0aND369w/kLZs3wk3RMvbJlwUfT7Zb30ezwHADsVJ83laR
 ri8EuaZTjuqAUeyo6PLRt5B5izvpQnFzibxYL37F2koVuqeLKvmucS8D5Oxov3T0OR0K
 q4kQeWdgtzNh6B1h582p1uebyuxx2aNA94RfdQ9Kt2+XSz6U0DZ3jFu3vNlQ9Vrp35oJ
 Utt/Crgzuk5kwNaPaiyjDct8rM/7UyHDYpTBAgBheyGQtwRCrKdfNi0RVasmUitkR3xS
 UyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a7dqyj5cuUATWqNomX1lzd1a0dS44usP0OrTroPvyR8=;
 b=k97OelJ38VbhGa26IweIDJVdpjTcG5iBYRAcPumS0GPrIJIFhm3pvV7UZenaebsM4p
 HyBC/U8ChYr0oQGmfOKD8wTmyX/9m93cunyAs5Kx/4L2fbLxLCNeZg3ZulTloNqNxTby
 8Oya9/VqkYZ50XHeKICSPS1i156gtThWmFgNbn4qerBJ8MAqjwQy+ozWGke2glP4bYR4
 KyXozyccl5umgIwP2svswL8GXAsIOdU2T0rDFJFidDpftXv99v0OcFATvgIy3rtdIXUS
 1CgvAGVP4MpTKa7ShAkux8qeh0U8MH7OEUQ7PKB4zU2LGEMA8+7C4Gjx6nR0B5JUFjDR
 ke9Q==
X-Gm-Message-State: AOAM533apLzMYgdXbLErDW96l1VI0fWbBiUj67cFlDwBSISwSzTfy3FH
 k4EYbBUcnioTGFuzg7qjgubJ7EZHoNU=
X-Google-Smtp-Source: ABdhPJwVJdSg7Z/mxghK4mYUIRgfQPbjXoJix6iRVvrNLYcfMhZGjUNx83MVvZDhjCKgbp39Li7/gQ==
X-Received: by 2002:a05:6000:1202:: with SMTP id
 e2mr7373981wrx.231.1592389929545; 
 Wed, 17 Jun 2020 03:32:09 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z6sm32380903wrh.79.2020.06.17.03.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 03:32:08 -0700 (PDT)
Date: Wed, 17 Jun 2020 11:32:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1882241 <1882241@bugs.launchpad.net>
Subject: Re: [Bug 1882241] [NEW] file transfer over cifs to 64bit guest
 corrupts large files
Message-ID: <20200617103206.GA1728005@stefanha-x1.localdomain>
References: <159136023930.32294.17616621945608188739.malonedeb@gac.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <159136023930.32294.17616621945608188739.malonedeb@gac.canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x42a.google.com
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


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2020 at 12:30:39PM -0000, timsoft wrote:
> Public bug reported:
>=20
> qemu 4.0 compiled fom source.
> vm called by
> qemu-system-x86_64 -cpu qemu64 -smp 4 -m 4G -drive file=3D/data/images/sl=
ack14.2_64bit_test.qcow2,format=3Dqcow2 -cdrom /mnt/smb1/slackware/iso/slac=
kware64-14.2-install-dvd.iso -boot c -net nic,macaddr=3D02:00:00:11:11:17,m=
odel=3Di82551 -net bridge,br=3Dbr0 -enable-kvm -k en-gb -display vnc=3D:3 -=
monitor telnet:localhost:7103,server,nowait,nodelay
>=20
> copying large files eg 2.4gb or reading them on a cifs mount in the guest=
 causes corruption every time. For smaller files 40-60mb corruption is more=
 than 50% of the time. tested by md5sum on cifs server, or on host machine =
vs. on guest vm.
> corruption is seen only with 64bit guest using cifs with i82551 emulated =
network device
> ie. 32bit guest using cifs with i82551 emulated network device gives no c=
orruption.
>=20
> changing the emulated device to vmxnet3 removes the data corruption (see
> below)
>=20
> qemu-system-x86_64 -cpu qemu64 -smp 4 -m 4G -drive
> file=3D/data/images/slack14.2_64bit_test.qcow2,format=3Dqcow2 -cdrom
> /mnt/smb1/slackware/iso/slackware64-14.2-install-dvd.iso -boot c -net
> nic,macaddr=3D02:00:00:11:11:17,model=3Dvmxnet3 -net bridge,br=3Dbr0 -ena=
ble-
> kvm -k en-gb -display vnc=3D:3 -monitor
> telnet:localhost:7103,server,nowait,nodelay
>=20
> this corruption is repeatable. ie. I created new vm, call using top examp=
le, installed 64bit linux, mounted cifs share and copied 2.4gb file to /tmp=
 then run md5sum "filecopied"
> the md5sum is different every time. copy same file to the host, or to a 3=
2bit guest with the same virtual network device and bridge and md5sums are =
correct. The host pysical network adapter is
> lspci|grep Ether
> 1e:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168=
/8411 PCI Express Gigabit Ethernet Controller (rev 11)
>=20
> physically connected via gigabit ethernet to cifs server (via gigabit
> switch)

Not a solution but some comments:

1. As a sanity-check you could try "nc <guest-ip> 1234 </path/to/file" on
   the host and "nc -l -p 1234 >/tmp/file" in the guest. Netcat simply
   sends/receives data over a TCP connection (it's a much simpler test
   than CIFS). Is the checksum okay?

2. I don't know the CIFS network protocol, but if Wireshark can dissect
   it then you could compare the flows between the vmxnet3 and the
   i82551. This is only feasible if Wireshark can produce an unencrypted
   conversation and the CIFS protocol doesn't have many protocol header
   fields that differ between two otherwise identical sessions.

3. virtio-net is the most widely used and high-performance NIC model.
   Other emulated NIC models are mainly there for very old guests that
   lack virtio guest drivers.

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7p8SYACgkQnKSrs4Gr
c8jwHQf/bI/7/ZD0LN4eIFOG+yqe8Dh5gaJZGMl4q8djO2yT2ErT2WiBSKfbjZrn
ERokOtxQ2Jsk9BngxoH48zj3q011z/xdKuHDN1HZb16aZMili/HwqXPn623/CVcG
dfrDaX5NR2RMQfoLPj8wSy8FN6ulcUVOnsZCz0iIMom8ARn0rOtU6yF8VVjTYGvg
ewPr4yN2zPawPJiSSsyewmYV2i8tGO4eDqj+IBz0A3lrgldln3tkKwunE/2JiOPF
HNaLqVCNu8SBJopVjGIIUMpgadBVbbAHscrTNoB3+a24UEWcsTBt+3yFB3e3u3Vb
cYZXwTu/ur5fb7rnWVzqG6wM7OwEvg==
=s3Gs
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

