Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E323C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 339A82073B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="mXkovfIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339A82073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc1WW-0002Kz-4G
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 02:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jc1T7-0007Pd-Cq
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:47:45 -0400
Received: from mout.web.de ([212.227.15.14]:40147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jc1T5-00015J-Oy
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590130048;
 bh=onX8+eQAJxthEvUbTQh20bjXAEdcEmN1bvH9zgAEgk0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=mXkovfIHRFGlXVaKAeoySt22wXyq+RA0gr/UZS6CquKTxqVUwIOmMTdx7rX6TvgIt
 0gWFIh6OnOguVxVYySJGCJeEuX6waJw1nyBi6C8KLUC2SirmlsiSoaqFYow1HFdx49
 ETYzriCwndzDMiPw1snCEa38r4ZVO++0fKvHPXaY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.67]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lsvn8-1iviiw2I2s-012aXT; Fri, 22
 May 2020 08:47:28 +0200
Date: Fri, 22 May 2020 08:47:19 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 0/6] colo-compare bugfixes
Message-ID: <cover.1590129793.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ftwkrz8Iz7lvwgX7Q9W0QH6";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:NiUJLQpviNtbcszz/zj7SxLwwYxQadGVi3SZbxS2+fhAzunFEP9
 JJYbfeKM4XA5fAxsr7Gqe2+DPzT+fFY9Odg5lI8enPLMKrPKBCtvzRD5lhzdDAj3/Ko13Vs
 LO8qu8Ba9D3/EkLeFIc1rKef6FOfyes+1Etor+ykt4ldyPzFs6dpZRqdYiHooBCuFjn0RWS
 pV2Hd+yzmkWl9RVSv1xTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Vh5LKBqKjk=:Pe+cxeyifmUnolfg/QcEZW
 fGDA5MV3R6JI2E1Tec3WZ3rtYa/80bj09rDVTkP9ChTsfV9u6oKgM+DMlC2TtHZTLdw38itdL
 GOlowix9iFA04d6/rie6z/7l7uFGqBBzEiK3MirwmdVJK3+4yxyNQhM1GUOCg6Q/c12W+jKu0
 D7eRDNz1j1+wDYhT7qdXWhzTDBNCzs07wRWvpKMEEx0Qdo+zeLWtCH9UO0SJLX5jIamEveIcQ
 n198roUBY7GCoGlGHHH1oTDwEPO3udqDnyUKVrKRXnjP0piEhET6MeDXtO4GMdcXSoTbLGOhI
 2Jpz43Oi0x58ItuuvkHs34kZXW4d3DhK/PTIWxm/pa+pYv1dB+CPV01U9rY7hjqNW2+lArJTm
 iBvbFdUG4cJ3PZo8coMkUjdoS6dus8kZNf5WO7oi6MTJr0T3PPOAgsuH11gF2+RdmRl3X+OiE
 ykU8quBmGPfZOAry5N11mNck5L1C8C+zquKaEA2rSm8bTcVlG6UJNwspYvkmH23bA2vOYdzgF
 1tRsTzvchjrKztUQ7h8q3wFe8bETfn0gjB60A4Ln/qiMVYN6Hi5RS+6pZxlGFMfkIGii9vjkh
 XamF6jBCGecgmWQlNIDa5Lm9AoxSVE+ju7VLfrsKFlnjTq90iZsK3v7ZwqQg7gf0lvF1HJD/+
 pWEXBALRE8M0e72Xm4Kj0GI6wZ+x3JdaI/W48wqXumlKwg/ad3pV+IdUAUQLcKuTKyDNyqRYs
 nk1kPDedlDa7ezgFFYEBpYBD/hvNs56KxJYE8j9Lzbtb7+BCOA0FkDuh/hY9a2I63/mwWfJJA
 hPbPgwjEQ9jG/Tl8DO5x23YSU8axcAekWlXiR7uo7K09QN91Ks2kQYvtrkT9zEpE+VNOBSTxy
 MPPPmLVE+JwgGJfmVzT1e4HNzlnLfeZwQ6KE+Xpcadw0Q6ooJ6ZQBN9mSjBgyDENm5pc9ebZZ
 uVbrbEnPkucH8PhQ6H8WTxG8WJJ7/yem0TiUWL3xeeL0oo74lNyn09efkFxpxXvkUTEde/iOV
 dPx8fl9HeGiO+Y3YnMqSRhmGmUUZhVpUO2dbg+Zzna71+B5/MDS8tr4tk6g0vLkOWNhDwF/IQ
 bPpz1KJQbZAtCNFd9hA728qNR3Lxmh7hkVu0TimOxThYCoNPL2rRqrWQ40E5vk55xweegeVZQ
 kzuo1G9ga6S8qzKhRNXyicnAmQuBgYme71RI8pdwbEDRIPLd97aFcEhTwVLYr5oqrgnIRuXso
 bcOMdd2BMxL8MDst1
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 02:47:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/ftwkrz8Iz7lvwgX7Q9W0QH6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
Here are fixes for bugs that I found in my tests. I have tested this with my
test suite and everything works fine.

Regards,
Lukas Straub

Version changes:
v6:
 -don't touch softmmu/vl.c, use __contructor__ attribute instead
 -better wording

v5:
 -initialize and use notify_sendco only if notify_dev is set

v4:
 -fix potential deadlock with notify_remote_frame
 -avoid malloc and memcpy in many cases

v3:
 -fix checkpatch.pl error

v2:
 -better wording
 -fix performance-regression in patch 3 "net/colo-compare.c: Fix deadlock i=
n compare_chr_send"
 -add more bugfixes

Lukas Straub (6):
  net/colo-compare.c: Create event_bh with the right AioContext
  chardev/char.c: Use qemu_co_sleep_ns if in coroutine
  net/colo-compare.c: Fix deadlock in compare_chr_send
  net/colo-compare.c: Only hexdump packets if tracing is enabled
  net/colo-compare.c: Check that colo-compare is active
  net/colo-compare.c: Correct ordering in complete and finalize

 chardev/char.c     |   7 +-
 net/colo-compare.c | 254 ++++++++++++++++++++++++++++++++++-----------
 net/colo.c         |   7 ++
 net/colo.h         |   1 +
 4 files changed, 206 insertions(+), 63 deletions(-)

--
2.20.1

--Sig_/ftwkrz8Iz7lvwgX7Q9W0QH6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7HdXcACgkQNasLKJxd
sliKdxAAqw5Vec1DmeNK2384kTCKyrNGig9pYIup3XGJBjX6ZBeVm+8a35qqMsCF
oeh/zpAW6JLB6oftXhibfvVobRfRW2YMw/Dhl56ZvVUPZQopE5GLLAHUhL1g/ceg
TZJ6b6SickdT6yFOMgtzcmvk084miZo+VM/PRlLbEXPX9xY3SErUkvbf9YCx1Ule
3sVnCqXMFuQJwWX18jdYiOudJ+9BFaS8l4iyOqia2oEVyQgvpSeNMXgH6MCWZ69f
PrA/FjQ8GzNBuhZP9y3FmVLXuRjGy99DOhxmEDd7qN9CH5JIrPGYPZUzglF0dWNJ
5g8RBPdVWNO6i4X1W/WfdnPUuxNrUuvVhRAgbMXji2shsMY+nJl6owE3WRyKns1n
cD4tNsmYSJ+6sidYlVJsMiebYn/sLXgRTvkGxoZVkvhNGyCSf+TzxkPgt/YKqC0/
NoBgzA6kiWxg6XN4ihUmmSo3fF8ycs5MWtTCm4ylr3jX3WWKx+aVezJBg2q4Cr2+
PuLP/HmtNa4MslVGMLv2AQ5XGmLT8bsXW0YKuf9Mv1rkj86leDMNhwN1KTp0Nmp9
2dHQpnk3Q2JXrzk6yN6bOAnJAJG8w6K7xEeTxZ8WnKW7cdWlazZaxSE0/DDSGoTt
Cm8op9Nj36/VXDp3zfKu0jhpRDG+yOTS2ZT6IYuGMtR1TbJG5Pg=
=Sv66
-----END PGP SIGNATURE-----

--Sig_/ftwkrz8Iz7lvwgX7Q9W0QH6--

