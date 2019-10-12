Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7608EC47404
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 02:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4B5206CD
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 02:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4B5206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ7Cy-0001Wg-D5
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 22:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iJ7CC-0000o2-ID
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 22:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iJ7CA-0005EO-Sv
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 22:31:52 -0400
Resent-Date: Fri, 11 Oct 2019 22:31:52 -0400
Resent-Message-Id: <E1iJ7CA-0005EO-Sv@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iJ7CA-0005CS-LD
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 22:31:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570846255; cv=none; d=zoho.com; s=zohoarc; 
 b=VUxSVqeGjbYocgCxZ0W1FhNccn6cM6qZLCuYnRgoYA42haMRd+Fb5v5exSvA/b6QdDTcDDKBwdX9KLDYP9U868tPKJbWCQMxuRAQtoeD0TykR3JRVVlZxCn7Rw1LFtfcMhIZYz3dgKXhebsKc7fXiv0BGjKCsFfFGbv/JJgzmMY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570846255;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Nn+4ktKBi6cVLXwxBAHDx3j4KR5hpkHDis4KeeHetHY=; 
 b=kHqNrULIYgGoCxxHNWy0Vj7FuVcB+OAuwI1BahGD0g+0Nk4SMXAM164d6AIu6zcqmSsZjUuxTZKSRZZb+NMIyxqd//z1kYBlRn45TSHkc+8ntWAAggU01/c3K1oSZfYlMPF8NN6MA+4D+xgjKLtar6DTdJY/+DAB2WcVMZr0oio=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570846252297989.3517926014251;
 Fri, 11 Oct 2019 19:10:52 -0700 (PDT)
In-Reply-To: <20191011160552.22907-1-vsementsov@virtuozzo.com>
Subject: Re: [RFC v5 000/126] error: auto propagated local_err
Message-ID: <157084624355.16951.11945043823681183793@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Fri, 11 Oct 2019 19:10:52 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Reply-To: qemu-devel@nongnu.org
Cc: ronniesahlberg@gmail.com, codyprime@gmail.com, jan.kiszka@siemens.com,
 berto@igalia.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, samuel.thibault@ens-lyon.org, lersek@redhat.com,
 jasowang@redhat.com, lvivier@redhat.com, ehabkost@redhat.com,
 xiechanglong.d@gmail.com, pl@kamp.de, dgilbert@redhat.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, stefanha@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 andrew@aj.id.au, crwulff@gmail.com, sundeep.lkml@gmail.com, michael@walle.cc,
 qemu-ppc@nongnu.org, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 fam@euphon.net, peter.maydell@linaro.org, sheepdog@lists.wpkg.org,
 mjrosato@linux.ibm.com, david@redhat.com, palmer@sifive.com,
 farman@linux.ibm.com, jcmvbkbc@gmail.com, den@openvz.org, hare@suse.com,
 sstabellini@kernel.org, arei.gonglei@huawei.com, namei.unix@gmail.com,
 atar4qemu@gmail.com, thuth@redhat.com, amit@kernel.org, sw@weilnetz.de,
 groug@kaod.org, yuval.shaia@oracle.com, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, peter.chubb@nicta.com.au, clg@kaod.org, shorne@gmail.com,
 qemu-riscv@nongnu.org, cohuck@redhat.com, amarkovic@wavecomp.com,
 aurelien@aurel32.net, pburton@wavecomp.com, sagark@eecs.berkeley.edu,
 paul@xen.org, green@moxielogic.com, kraxel@redhat.com,
 edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn, ari@tuxera.com,
 quintela@redhat.com, mdroth@linux.vnet.ibm.com, borntraeger@de.ibm.com,
 joel@jms.id.au, dillaman@redhat.com, antonynpavlov@gmail.com,
 xen-devel@lists.xenproject.org, integration@gluster.org, philmd@redhat.com,
 rjones@redhat.com, Andrew.Baumann@microsoft.com, mreitz@redhat.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 v.maffione@gmail.com, marex@denx.de, armbru@redhat.com,
 marcandre.lureau@redhat.com, alistair@alistair23.me, pavel.dovgaluk@ispras.ru,
 g.lettieri@iet.unipi.it, rizzo@iet.unipi.it, david@gibson.dropbear.id.au,
 akrowiak@linux.ibm.com, berrange@redhat.com, xiaoguangrong.eric@gmail.com,
 pmorel@linux.ibm.com, wencongyang2@huawei.com, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxMTE2MDU1Mi4yMjkw
Ny0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VO
Vj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgaW90
ZXN0LXFjb3cyOiAwMTMKICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rlc3QtYmxvY2staW90
aHJlYWQKICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rlc3QtaW1hZ2UtbG9ja2luZwp3YXJu
aW5nOiBGYWlsZWQgdG8gZ2V0IHNoYXJlZCAiY29uc2lzdGVudCByZWFkIiBsb2NrCklzIGFub3Ro
ZXIgcHJvY2VzcyB1c2luZyB0aGUgaW1hZ2UgWy90bXAvcXRlc3QuTzY2bDN0XT8Kd2FybmluZzog
RmFpbGVkIHRvIGdldCBzaGFyZWQgImNvbnNpc3RlbnQgcmVhZCIgbG9jawpJcyBhbm90aGVyIHBy
b2Nlc3MgdXNpbmcgdGhlIGltYWdlIFsvdG1wL3F0ZXN0LkcwTTlWOF0/CiAgVEVTVCAgICBjaGVj
ay11bml0OiB0ZXN0cy90ZXN0LXg4Ni1jcHVpZAogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMv
dGVzdC14YnpybGUKLS0tCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDI2NwpGYWlsdXJlczogMDU0
CkZhaWxlZCAxIG9mIDEwOCBpb3Rlc3RzCm1ha2U6ICoqKiBbY2hlY2stdGVzdHMvY2hlY2stYmxv
Y2suc2hdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4K
ICBURVNUICAgIGNoZWNrLXF0ZXN0LWFhcmNoNjQ6IHRlc3RzL3Fvcy10ZXN0ClRyYWNlYmFjayAo
bW9zdCByZWNlbnQgY2FsbCBsYXN0KToKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3Io
cmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydz
dWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5j
ZS51dWlkPTJjNTVmYjYxYTYzYTQwOTM4MmYyYjNhOTlmY2E5M2Q5JywgJy11JywgJzEwMDMnLCAn
LS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFS
R0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICct
ZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0ND
QUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9x
ZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0
Y2hldy10ZXN0ZXItdG1wLXVzdmk4Zm9iL3NyYy9kb2NrZXItc3JjLjIwMTktMTAtMTEtMjIuMDAu
MTAuMTkzMzovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3Fl
bXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4K
ZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MmM1NWZiNjFhNjNh
NDA5MzgyZjJiM2E5OWZjYTkzZDkKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1h
a2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtdXN2
aThmb2Ivc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJv
ciAyCgpyZWFsICAgIDEwbTMzLjcxNHMKdXNlciAgICAwbTguMzYwcwoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMTExNjA1NTIuMjI5
MDctMS12c2VtZW50c292QHZpcnR1b3p6by5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9z
Ny8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


