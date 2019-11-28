Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2077C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B6E21741
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B6E21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaI58-0005ly-Qw
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 06:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ning.bo9@zte.com.cn>) id 1iaHxk-00019L-KQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ning.bo9@zte.com.cn>) id 1iaHxi-0002YQ-3r
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:27:55 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:26908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ning.bo9@zte.com.cn>) id 1iaHxh-0001nQ-LL
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:27:54 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 258394830638078F26E1;
 Thu, 28 Nov 2019 19:27:44 +0800 (CST)
Received: from kjyxapp04.zte.com.cn ([10.30.12.203])
 by mse-fl1.zte.com.cn with SMTP id xASBQl3C034180;
 Thu, 28 Nov 2019 19:26:47 +0800 (GMT-8)
 (envelope-from ning.bo9@zte.com.cn)
Received: from mapi (kjyxapp03[null]) by mapi (Zmail) with MAPI id mid14;
 Thu, 28 Nov 2019 19:26:47 +0800 (CST)
Date: Thu, 28 Nov 2019 19:26:47 +0800 (CST)
X-Zmail-TransId: 2b055ddfaef79ae9d416
X-Mailer: Zmail v1.0
Message-ID: <201911281926474453744@zte.com.cn>
In-Reply-To: <20190809134134.GA8594@stefanha-x1.localdomain>
References: 1564975951-29263-1-git-send-email-ning.bo9@zte.com.cn,
 20190809134134.GA8594@stefanha-x1.localdomain
Mime-Version: 1.0
From: <ning.bo9@zte.com.cn>
To: <stefanha@gmail.com>
Subject: =?UTF-8?B?UmU6W1FlbXUtZGV2ZWxdIFtQQVRDSCB2Ml0gdmhvc3QtdnNvY2s6IHJlcG9ydCBRTVAgZXZlbnQgd2hlbiBzZXRydW5uaW5n?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn xASBQl3C034180
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 63.217.80.70
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



--=====_001_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

TGV0IG1lIGRlc2NyaWJlIHRoZSBpc3N1ZSB3aXRoIGFuIGV4YW1wbGUgdmlhIGBuYy12c29ja2A6
CgpMZXQncyBhc3N1bWUgdGhlIEd1ZXN0IGNpZCBpcyAzLgpleGVjdXRlICdybW1vZCB2bXdfdnNv
Y2tfdmlydGlvX3RyYW5zcG9ydCcgaW4gR3Vlc3QsCnRoZW4gZXhlY3V0ZSAnd2hpbGUgdHJ1ZTsg
ZG8gbmMtdnNvY2sgMyAxMjM0JyBpbiBIb3N0LgoKSG9zdCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgR3Vlc3QKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBybW1vZCB2bXdf
dnNvY2tfdmlydGlvX3RyYW5zcG9ydAoKIyB3aGlsZSB0cnVlOyBkbyAuL25jLXZzb2NrIDMgMTIz
NDsgZG9uZQooYWZ0ZXIgMiBzZWNvbmQpCmNvbm5lY3Q6IENvbm5lY3Rpb24gdGltZWQgb3V0Cihh
ZnRlciAyIHNlY29uZCkKY29ubmVjdDogQ29ubmVjdGlvbiB0aW1lZCBvdXQKLi4uCgogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAjIG1vZHByb2JlIHZtd192c29ja192aXJ0aW9fdHJh
bnNwb3J0Cgpjb25uZWN0OiBDb25uZWN0aW9uIHJlc2V0IGJ5IHBlZXIKY29ubmVjdDogQ29ubmVj
dGlvbiByZXNldCBieSBwZWVyCmNvbm5lY3Q6IENvbm5lY3Rpb24gcmVzZXQgYnkgcGVlcgouLi4K
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgbmMtdnNvY2sgLWwgMTIzNAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDb25uZXRpb24gZnJvbSBjaWQgMiBwb3J0ICoq
Ki4uLgooc3RvcCBwcmludGluZykKCgpUaGUgYWJvdmUgcHJvY2VzcyBzaW11bGF0ZXMgdGhlIGNv
bW11bmljYXRpb24gcHJvY2VzcyBiZXR3ZWVuCnRoZSBga2F0YS1ydW50aW1lYCBhbmQgYGthdGEt
YWdlbnRgIGFmdGVyIHN0YXJ0aW5nIHRoZSBHdWVzdC4KSW4gb3JkZXIgdG8gY29ubmVjdCB0byBg
a2F0YS1hZ2VudGAgYXMgc29vbiBhcyBwb3NzaWJsZSwgCmBrYXRhLXJ1bnRpbWVgIHdpbGwgY29u
dGludW91c2x5IHRyeSB0byBjb25uZWN0IHRvIGBrYXRhLWFnZW50YCBpbiBhIGxvb3AuCnNlZSBo
dHRwczovL2dpdGh1Yi5jb20va2F0YS1jb250YWluZXJzL3J1bnRpbWUvYmxvYi9kMDU0NTU2ZjYw
ZjA5MjMzNWEyMmEyODgwMTFmYTI5NTM5YWQ0Y2NjL3ZlbmRvci9naXRodWIuY29tL2thdGEtY29u
dGFpbmVycy9hZ2VudC9wcm90b2NvbHMvY2xpZW50L2NsaWVudC5nbyNMMzI3CkJ1dCB3aGVuIHRo
ZSB2c29jayBkZXZpY2UgaW4gdGhlIEd1ZXN0IGlzIG5vdCByZWFkeSwgdGhlIGNvbm5lY3Rpb24K
d2lsbCBibG9jayBmb3IgMiBzZWNvbmRzLiBUaGlzIHNpdHVhdGlvbiBhY3R1YWxseSBzbG93cyBk
b3duCnRoZSBlbnRpcmUgc3RhcnR1cCB0aW1lIG9mIGBrYXRhLXJ1bnRpbWVgLgoKCj4gSSB0aGlu
ayB0aGF0IGFkZGluZyBhIFFNUCBldmVudCBpcyB3b3JraW5nIGFyb3VuZCB0aGUgaXNzdWUgcmF0
aGVyIHRoYW4KPiBmaXhpbmcgdGhlIHJvb3QgY2F1c2UuICBUaGlzIGlzIHByb2JhYmx5IGEgdmhv
c3RfdnNvY2sua28gcHJvYmxlbSBhbmQKPiBzaG91bGQgYmUgZml4ZWQgdGhlcmUuCgpBZnRlciBs
b29raW5nIGF0IHRoZSBzb3VyY2UgY29kZSBvZiB2aG9zdF92c29jay5rbywgCkkgdGhpbmsgaXQg
aXMgcG9zc2libGUgdG8gb3B0aW1pemUgdGhlIGxvZ2ljIGhlcmUgdG9vLgpUaGUgc2ltcGxlIHBh
dGNoIGlzIGFzIGZvbGxvd3MuIERvIHlvdSB0aGluayB0aGUgbW9kaWZpY2F0aW9uIGlzIGFwcHJv
cHJpYXRlPwoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdnNvY2suYyBiL2RyaXZlcnMvdmhv
c3QvdnNvY2suYwppbmRleCA5ZjU3NzM2Zi4uOGZhZDY3YmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
dmhvc3QvdnNvY2suYworKysgYi9kcml2ZXJzL3Zob3N0L3Zzb2NrLmMKQEAgLTUxLDYgKzUxLDcg
QEAgc3RydWN0IHZob3N0X3Zzb2NrIHsKIAlhdG9taWNfdCBxdWV1ZWRfcmVwbGllczsKCiAJdTMy
IGd1ZXN0X2NpZDsKKwl1MzIgc3RhdGU7CiB9OwoKIHN0YXRpYyB1MzIgdmhvc3RfdHJhbnNwb3J0
X2dldF9sb2NhbF9jaWQodm9pZCkKQEAgLTQ5Nyw2ICs1NDEsNyBAQCBzdGF0aWMgaW50IHZob3N0
X3Zzb2NrX3N0YXJ0KHN0cnVjdCB2aG9zdF92c29jayAqdnNvY2spCgogCQltdXRleF91bmxvY2so
JnZxLT5tdXRleCk7CiAJfQorCXZzb2NrLT5zdGF0ZSA9IDE7CgogCW11dGV4X3VubG9jaygmdnNv
Y2stPmRldi5tdXRleCk7CiAJcmV0dXJuIDA7CkBAIC01MzUsNiArNTgwLDcgQEAgc3RhdGljIGlu
dCB2aG9zdF92c29ja19zdG9wKHN0cnVjdCB2aG9zdF92c29jayAqdnNvY2spCiAJCXZxLT5wcml2
YXRlX2RhdGEgPSBOVUxMOwogCQltdXRleF91bmxvY2soJnZxLT5tdXRleCk7CiAJfQorCXZzb2Nr
LT5zdGF0ZSA9IDA7CgogZXJyOgogCW11dGV4X3VubG9jaygmdnNvY2stPmRldi5tdXRleCk7CkBA
IC03ODYsNiArODMyLDI3IEBAIHN0YXRpYyBzdHJ1Y3QgbWlzY2RldmljZSB2aG9zdF92c29ja19t
aXNjID0gewogCS5mb3BzID0gJnZob3N0X3Zzb2NrX2ZvcHMsCiB9OwoKK2ludCB2aG9zdF90cmFu
c3BvcnRfY29ubmVjdChzdHJ1Y3QgdnNvY2tfc29jayAqdnNrKSB7CisJc3RydWN0IHZob3N0X3Zz
b2NrICp2c29jazsKKworCXJjdV9yZWFkX2xvY2soKTsKKworCS8qIEZpbmQgdGhlIHZob3N0X3Zz
b2NrIGFjY29yZGluZyB0byBndWVzdCBjb250ZXh0IGlkICAqLworCXZzb2NrID0gdmhvc3RfdnNv
Y2tfZ2V0KHZzay0+cmVtb3RlX2FkZHIuc3ZtX2NpZCk7CisJaWYgKCF2c29jaykgeworCQlyY3Vf
cmVhZF91bmxvY2soKTsKKwkJcmV0dXJuIC1FTk9ERVY7CisJfQorCisJcmN1X3JlYWRfdW5sb2Nr
KCk7CisKKwlpZiAodnNvY2stPnN0YXRlID09IDEpIHsKKwkJcmV0dXJuIHZpcnRpb190cmFuc3Bv
cnRfY29ubmVjdCh2c2spOworCX0gZWxzZSB7CisJCXJldHVybiAtRUNPTk5SRVNFVDsKKwl9Cit9
CisKIHN0YXRpYyBzdHJ1Y3QgdmlydGlvX3RyYW5zcG9ydCB2aG9zdF90cmFuc3BvcnQgPSB7CiAJ
LnRyYW5zcG9ydCA9IHsKIAkJLmdldF9sb2NhbF9jaWQgICAgICAgICAgICA9IHZob3N0X3RyYW5z
cG9ydF9nZXRfbG9jYWxfY2lkLApAQCAtNzkzLDcgKzg2MCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgdmly
dGlvX3RyYW5zcG9ydCB2aG9zdF90cmFuc3BvcnQgPSB7CiAJCS5pbml0ICAgICAgICAgICAgICAg
ICAgICAgPSB2aXJ0aW9fdHJhbnNwb3J0X2RvX3NvY2tldF9pbml0LAogCQkuZGVzdHJ1Y3QgICAg
ICAgICAgICAgICAgID0gdmlydGlvX3RyYW5zcG9ydF9kZXN0cnVjdCwKIAkJLnJlbGVhc2UgICAg
ICAgICAgICAgICAgICA9IHZpcnRpb190cmFuc3BvcnRfcmVsZWFzZSwKLQkJLmNvbm5lY3QgICAg
ICAgICAgICAgICAgICA9IHZpcnRpb190cmFuc3BvcnRfY29ubmVjdCwKKwkJLmNvbm5lY3QgICAg
ICAgICAgICAgICAgICA9IHZob3N0X3RyYW5zcG9ydF9jb25uZWN0LAogCQkuc2h1dGRvd24gICAg
ICAgICAgICAgICAgID0gdmlydGlvX3RyYW5zcG9ydF9zaHV0ZG93biwKIAkJLmNhbmNlbF9wa3Qg
ICAgICAgICAgICAgICA9IHZob3N0X3RyYW5zcG9ydF9jYW5jZWxfcGt0LA==


--=====_003_next=====--

--=====_001_next=====--


