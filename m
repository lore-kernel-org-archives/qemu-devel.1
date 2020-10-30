Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2EEC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA21206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA21206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYUAM-0006XU-It
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 09:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kYU7Z-00044M-3R
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 09:07:09 -0400
Resent-Date: Fri, 30 Oct 2020 09:07:09 -0400
Resent-Message-Id: <E1kYU7Z-00044M-3R@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kYU7Q-0007e4-EE
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 09:07:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1604063207; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=A92/oVb8/JRn4Bpl9CqILvFaAKDzv+CkXIzDTUMrrfLx46T7pzKJZozLJjFmD+BPJ/+CqLJYYTux6IX+eHag9/XtB0BD4SV/aDBN78rlMlnm3xMF2OPY53mwlXJKr3/CUsMWH8tyV9eSKwIRME6h5cuPGMsGOipEpFTM+0CTeVU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1604063207;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=cJjA+tzE8NiMYYpz/FRgJEKrRIMHBuQQkySqgKL4GCY=; 
 b=Qm7APvRO0fJ74yfQ7uiU/BDg0C/23TSzMe52UWB1W70RLoWo1sLYzJH7mCRHdOjayN90Gb1KAV3KA7rHuLruPYiqL4Xnm/gM92IC8DnSdCsPi6QNdpDVIO7hIuai/j7HwEjw8x2UBBUwuKfYLR4833EmvGCpeDQbJ6s064OjBT0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1604063205111313.987010856981;
 Fri, 30 Oct 2020 06:06:45 -0700 (PDT)
Subject: Re: [PULL 00/15] pc,pci,vhost,virtio: misc fixes
Message-ID: <160406320393.5222.12264353179537422434@66eaa9a8a123>
In-Reply-To: <20201030124454.854286-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mst@redhat.com
Date: Fri, 30 Oct 2020 06:06:45 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 09:06:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAzMDEyNDQ1NC44NTQy
ODYtMS1tc3RAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAxMDMwMTI0NDU0Ljg1NDI4Ni0x
LW1zdEByZWRoYXQuY29tClN1YmplY3Q6IFtQVUxMIDAwLzE1XSBwYyxwY2ksdmhvc3QsdmlydGlv
OiBtaXNjIGZpeGVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCBy
ZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2tw
YXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRp
bmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8v
Z2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRj
aGV3LzIwMjAxMDMwMTI0NDU0Ljg1NDI4Ni0xLW1zdEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAy
MDEwMzAxMjQ0NTQuODU0Mjg2LTEtbXN0QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJh
bmNoICd0ZXN0JwozOWY0Nzg4IGludGVsX2lvbW11OiBGaXggdHdvIG1pc3VzZSBvZiAiMHgldSIg
cHJpbnRzCjc0ZjJkY2VjIHZpcnRpbzogc2tpcCBndWVzdCBpbmRleCBjaGVjayBvbiBkZXZpY2Ug
bG9hZAowOWI4ZGIzIHZob3N0LWJsazogc2V0IGZlYXR1cmVzIGJlZm9yZSBzZXR0aW5nIGluZmxp
Z2h0IGZlYXR1cmUKYzQxNTNlYyBwY2k6IERpc2FsbG93IGltcHJvcGVyIEJBUiByZWdpc3RyYXRp
b24gZm9yIHR5cGUgMQphM2Y3OTM1IHBjaTogQ2hhbmdlIGVycm9yX3JlcG9ydCB0byBhc3NlcnQo
MykKZjRhZTRjNCBwY2k6IGFkdmVydGlzZSBhIHBhZ2UgYWxpZ25lZCBBVFMKZjdjMGVmYSBwYzog
SW1wbGVtZW50IC1uby1ocGV0IGFzIHN1Z2FyIGZvciAtbWFjaGluZSBocGV0PW9uCmRjNTE5ZjEg
dmhvc3Q6IERvbid0IHNwZWNpYWwgY2FzZSB2cS0+dXNlZF9waHlzIGluIHZob3N0X2dldF9sb2df
c2l6ZSgpCmJhNTVlZDEgcGNpOiBBc3NlcnQgaXJxbnVtIGlzIGJldHdlZW4gMCBhbmQgYnVzLT5u
aXJxcyBpbiBwY2lfYnVzX2NoYW5nZV9pcnFfbGV2ZWwKOGEyOTk1MiBody9wY2k6IEV4dHJhY3Qg
cGNpX2J1c19jaGFuZ2VfaXJxX2xldmVsKCkgZnJvbSBwY2lfY2hhbmdlX2lycV9sZXZlbCgpCjlm
NzE1ZDggaHcvdmlydGlvL3Zob3N0LXZkcGE6IEZpeCBDb3Zlcml0eSBDSUQgMTQzMjg2NAo2YjI2
MTBiIGFjcGkvY3JzOiBTdXBwb3J0IHJhbmdlcyA+IDMyYiBmb3IgaG9zdHMKZTA3OGE4YiBhY3Bp
L2NyczogUHJldmVudCBiYWQgcmFuZ2VzIGZvciBob3N0IGJyaWRnZXMKMmY0MGU0YyB2aG9zdC12
c29jazogc2V0IHZob3N0ZmQgdG8gbm9uLWJsb2NraW5nIG1vZGUKM2U2MzY0YyB2aG9zdC12ZHBh
OiBuZWdvdGlhdGUgVklSVElPX05FVF9GX1NUQVRVUyB3aXRoIGRyaXZlcgoKPT09IE9VVFBVVCBC
RUdJTiA9PT0KMS8xNSBDaGVja2luZyBjb21taXQgM2U2MzY0YzE3ODU1ICh2aG9zdC12ZHBhOiBu
ZWdvdGlhdGUgVklSVElPX05FVF9GX1NUQVRVUyB3aXRoIGRyaXZlcikKMi8xNSBDaGVja2luZyBj
b21taXQgMmY0MGU0Y2I0MzVlICh2aG9zdC12c29jazogc2V0IHZob3N0ZmQgdG8gbm9uLWJsb2Nr
aW5nIG1vZGUpCjMvMTUgQ2hlY2tpbmcgY29tbWl0IGUwNzhhOGIzZGE1MiAoYWNwaS9jcnM6IFBy
ZXZlbnQgYmFkIHJhbmdlcyBmb3IgaG9zdCBicmlkZ2VzKQo0LzE1IENoZWNraW5nIGNvbW1pdCA2
YjI2MTBiMTRkMWMgKGFjcGkvY3JzOiBTdXBwb3J0IHJhbmdlcyA+IDMyYiBmb3IgaG9zdHMpCjUv
MTUgQ2hlY2tpbmcgY29tbWl0IDlmNzE1ZDgzOTYyMyAoaHcvdmlydGlvL3Zob3N0LXZkcGE6IEZp
eCBDb3Zlcml0eSBDSUQgMTQzMjg2NCkKNi8xNSBDaGVja2luZyBjb21taXQgOGEyOTk1MjY3MGZh
IChody9wY2k6IEV4dHJhY3QgcGNpX2J1c19jaGFuZ2VfaXJxX2xldmVsKCkgZnJvbSBwY2lfY2hh
bmdlX2lycV9sZXZlbCgpKQo3LzE1IENoZWNraW5nIGNvbW1pdCBiYTU1ZWQxNmIzOTIgKHBjaTog
QXNzZXJ0IGlycW51bSBpcyBiZXR3ZWVuIDAgYW5kIGJ1cy0+bmlycXMgaW4gcGNpX2J1c19jaGFu
Z2VfaXJxX2xldmVsKQo4LzE1IENoZWNraW5nIGNvbW1pdCBkYzUxOWYxOTA5NWYgKHZob3N0OiBE
b24ndCBzcGVjaWFsIGNhc2UgdnEtPnVzZWRfcGh5cyBpbiB2aG9zdF9nZXRfbG9nX3NpemUoKSkK
OS8xNSBDaGVja2luZyBjb21taXQgZjdjMGVmYWQzZjMyIChwYzogSW1wbGVtZW50IC1uby1ocGV0
IGFzIHN1Z2FyIGZvciAtbWFjaGluZSBocGV0PW9uKQpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1
c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojNTM6IEZJTEU6IGh3L2kzODYvcGMu
YzoxMTUyOgorICAgICAgICAvKiBGb3IgcGMtcGlpeC0qLCBocGV0J3MgaW50Y2FwIGlzIGFsd2F5
cyBJUlEyLiBGb3IgcGMtcTM1LTEuNwoKV0FSTklORzogQmxvY2sgY29tbWVudHMgc2hvdWxkIGFs
aWduIHRoZSAqIG9uIGVhY2ggbGluZQojNTQ6IEZJTEU6IGh3L2kzODYvcGMuYzoxMTUzOgorICAg
ICAgICAvKiBGb3IgcGMtcGlpeC0qLCBocGV0J3MgaW50Y2FwIGlzIGFsd2F5cyBJUlEyLiBGb3Ig
cGMtcTM1LTEuNworICAgICAgICAgICAgKiBhbmQgZWFybGllciwgdXNlIElSUTIgZm9yIGNvbXBh
dC4gT3RoZXJ3aXNlLCB1c2UgSVJRMTZ+MjMsCgp0b3RhbDogMCBlcnJvcnMsIDIgd2FybmluZ3Ms
IDEyNyBsaW5lcyBjaGVja2VkCgpQYXRjaCA5LzE1IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
CjEwLzE1IENoZWNraW5nIGNvbW1pdCBmNGFlNGM0ZGYxZTYgKHBjaTogYWR2ZXJ0aXNlIGEgcGFn
ZSBhbGlnbmVkIEFUUykKMTEvMTUgQ2hlY2tpbmcgY29tbWl0IGEzZjc5MzUyYzUwZiAocGNpOiBD
aGFuZ2UgZXJyb3JfcmVwb3J0IHRvIGFzc2VydCgzKSkKMTIvMTUgQ2hlY2tpbmcgY29tbWl0IGM0
MTUzZWNjMmY4YyAocGNpOiBEaXNhbGxvdyBpbXByb3BlciBCQVIgcmVnaXN0cmF0aW9uIGZvciB0
eXBlIDEpCjEzLzE1IENoZWNraW5nIGNvbW1pdCAwOWI4ZGIzNzA0MWYgKHZob3N0LWJsazogc2V0
IGZlYXR1cmVzIGJlZm9yZSBzZXR0aW5nIGluZmxpZ2h0IGZlYXR1cmUpCkVSUk9SOiB0cmFpbGlu
ZyB3aGl0ZXNwYWNlCiM0NTogRklMRTogaHcvdmlydGlvL3Zob3N0LmM6MTY1MToKKyAkCgpFUlJP
UjogdHJhaWxpbmcgd2hpdGVzcGFjZQojNTA6IEZJTEU6IGh3L3ZpcnRpby92aG9zdC5jOjE2NTY6
CisgJAoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCA0MyBsaW5lcyBjaGVja2VkCgpQYXRj
aCAxMy8xNSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMTQvMTUgQ2hlY2tpbmcgY29tbWl0
IDc0ZjJkY2VjYTkyYyAodmlydGlvOiBza2lwIGd1ZXN0IGluZGV4IGNoZWNrIG9uIGRldmljZSBs
b2FkKQoxNS8xNSBDaGVja2luZyBjb21taXQgMzlmNDc4OGVlZmMwIChpbnRlbF9pb21tdTogRml4
IHR3byBtaXN1c2Ugb2YgIjB4JXUiIHByaW50cykKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDEwMzAxMjQ0NTQuODU0Mjg2LTEtbXN0QHJlZGhh
dC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

