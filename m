Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DA2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 21:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72792065F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 21:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72792065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcFAI-0008DP-S4
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 17:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcF9O-0007Xm-Lx; Fri, 22 May 2020 17:24:18 -0400
Resent-Date: Fri, 22 May 2020 17:24:18 -0400
Resent-Message-Id: <E1jcF9O-0007Xm-Lx@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcF9M-0006xU-Ld; Fri, 22 May 2020 17:24:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590182638; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fbYi0NKjxg51meSP80WGHJQKoxIDyIp/emsVfGNL43oAFAoZisPuXlEMHgIpKMOdionXQy3mTyY6MbWt186f3PuiqX1XYSLo2Gkovf6qIQDlRf99zfjfJEyC9T14CnnNmuyMTFGjT4B5zWry+6YqWSQ5cBUeF2YC6EZcIJEVdX8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590182638;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ulYG2U8h1wRNIbsjFqIExZtqo6cT6oHvgxVBilDt8L0=; 
 b=T1nS+rEHirN7ofALEq6V9+EUTSA90hPpLcPB+Iy8ei++kuJwWKSkRuUcWmikFrLIzM55u1+VRndCv28A40ebVjKdbt6bGhIylyi+6Gbd8+aPCRBAdkIjv8HfM9GkJ4eLijl+YAYjwBUiJHghGGb11dslEXubFFGif0euAwkqxGk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590182637089420.29755208233655;
 Fri, 22 May 2020 14:23:57 -0700 (PDT)
Message-ID: <159018263538.1576.4576279233747867926@45ef0f9c86ae>
In-Reply-To: <20200522161950.2839-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 0/3] coroutines: generate wrapper code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Fri, 22 May 2020 14:23:57 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 17:18:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Reply-To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyMjE2MTk1MC4yODM5
LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgYXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQK
dGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2Fu
IHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3Jh
IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRf
TElTVD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKL3RtcC9xZW11LXRlc3Qvc3JjL25iZC9zZXJ2ZXIuYzoxNTA0OiB1bmRlZmluZWQgcmVmZXJl
bmNlIHRvIGBiZHJ2X2ludmFsaWRhdGVfY2FjaGUnCi91c3IvYmluL2xkOiBxZW11LWltZy5vOiBp
biBmdW5jdGlvbiBgY29sbGVjdF9pbWFnZV9jaGVjayc6Ci90bXAvcWVtdS10ZXN0L3NyYy9xZW11
LWltZy5jOjY5NTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgYmRydl9jaGVjaycKY2xhbmctODog
ZXJyb3I6IGxpbmtlciBjb21tYW5kIGZhaWxlZCB3aXRoIGV4aXQgY29kZSAxICh1c2UgLXYgdG8g
c2VlIGludm9jYXRpb24pCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazox
MjQ6IHFlbXUtaW9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9i
cy4uLi4KL3Vzci9iaW4vbGQ6ICAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9hY2NlbC9zdHVicy9o
YXgtc3R1Yi5vCmJsb2NrLm86IGluIGZ1bmN0aW9uIGBiZHJ2X3Jlb3Blbl9wcmVwYXJlJzoKLS0t
Ci91c3IvYmluL2xkOiBibG9jay92aGR4LWxvZy5vOiBpbiBmdW5jdGlvbiBgdmhkeF9sb2dfd3Jp
dGVfYW5kX2ZsdXNoJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3ZoZHgtbG9nLmM6MTA0OTog
dW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgYmRydl9mbHVzaCcKL3Vzci9iaW4vbGQ6IC90bXAvcWVt
dS10ZXN0L3NyYy9ibG9jay92aGR4LWxvZy5jOjEwNjE6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YGJkcnZfZmx1c2gnCmNsYW5nLTg6IGVycm9yOiBsaW5rZXIgY29tbWFuZCBmYWlsZWQgd2l0aCBl
eGl0IGNvZGUgMSAodXNlIC12IHRvIHNlZSBpbnZvY2F0aW9uKQptYWtlOiAqKiogWy90bXAvcWVt
dS10ZXN0L3NyYy9ydWxlcy5tYWs6MTI0OiBxZW11LXN0b3JhZ2UtZGFlbW9uXSBFcnJvciAxCi91
c3IvYmluL2xkOiBibG9jay9wYXJhbGxlbHMubzogaW4gZnVuY3Rpb24gYHBhcmFsbGVsc19jbG9z
ZSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9wYXJhbGxlbHMuYzo4OTg6IHVuZGVmaW5lZCBy
ZWZlcmVuY2UgdG8gYGJkcnZfdHJ1bmNhdGUnCi91c3IvYmluL2xkOiBibG9jay9wYXJhbGxlbHMu
bzogaW4gZnVuY3Rpb24gYHBhcmFsbGVsc19jb19jaGVjayc6Ci0tLQovdG1wL3FlbXUtdGVzdC9z
cmMvYmxvY2svaW8uYzoyNTg0OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBiZHJ2X3J3X3Ztc3Rh
dGUnCi91c3IvYmluL2xkOiBuYmQvc2VydmVyLm86IGluIGZ1bmN0aW9uIGBuYmRfZXhwb3J0X25l
dyc6Ci90bXAvcWVtdS10ZXN0L3NyYy9uYmQvc2VydmVyLmM6MTUwNDogdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0byBgYmRydl9pbnZhbGlkYXRlX2NhY2hlJwpjbGFuZy04OiBlcnJvcjogbGlua2VyIGNv
bW1hbmQgZmFpbGVkIHdpdGggZXhpdCBjb2RlIDEgKHVzZSAtdiB0byBzZWUgaW52b2NhdGlvbikK
bWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjEyNDogcWVtdS1uYmRdIEVy
cm9yIDEKICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2FjY2VsL3RjZy90Y2ctcnVudGltZS1ndmVj
Lm8KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2FjY2VsL3RjZy9jcHUtZXhlYy5vCmNsYW5nLTg6
IGVycm9yOiBsaW5rZXIgY29tbWFuZCBmYWlsZWQgd2l0aCBleGl0IGNvZGUgMSAodXNlIC12IHRv
IHNlZSBpbnZvY2F0aW9uKQptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6
MTI0OiBxZW11LWltZ10gRXJyb3IgMQogIENDICAgICAgeDg2XzY0LXNvZnRtbXUvYWNjZWwvdGNn
L2NwdS1leGVjLWNvbW1vbi5vCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9hY2NlbC90Y2cvdHJh
bnNsYXRlLWFsbC5vCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9hY2NlbC90Y2cvdHJhbnNsYXRv
ci5vCi0tLQovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svaW8uYzoyNTg0OiB1bmRlZmluZWQgcmVm
ZXJlbmNlIHRvIGBiZHJ2X3J3X3Ztc3RhdGUnCi91c3IvYmluL2xkOiAuLi9uYmQvc2VydmVyLm86
IGluIGZ1bmN0aW9uIGBuYmRfZXhwb3J0X25ldyc6Ci90bXAvcWVtdS10ZXN0L3NyYy9uYmQvc2Vy
dmVyLmM6MTUwNDogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgYmRydl9pbnZhbGlkYXRlX2NhY2hl
JwpjbGFuZy04OiBlcnJvcjogbGlua2VyIGNvbW1hbmQgZmFpbGVkIHdpdGggZXhpdCBjb2RlIDEg
KHVzZSAtdiB0byBzZWUgaW52b2NhdGlvbikKbWFrZVsxXTogKioqIFtNYWtlZmlsZToyMDg6IHFl
bXUtc3lzdGVtLXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjUzMzogeDg2XzY0
LXNvZnRtbXUvYWxsXSBFcnJvciAyClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToK
ICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4K
ICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0
Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRv
JywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51
dWlkPTBhZTQ0ZjQ1ZmYyMTRhYWNiNjk4ZjM4MmM4MjM0MjJiJywgJy11JywgJzEwMDEnLCAnLS1z
ZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VU
X0xJU1Q9eDg2XzY0LXNvZnRtbXUnLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1l
JywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScs
ICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3
Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWR3Z185Y3Y0L3NyYy9kb2NrZXItc3JjLjIwMjAtMDUt
MjItMTcuMTkuMDQuMzEwMTI6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92
YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtZGVidWcnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBz
dGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MGFl
NDRmNDVmZjIxNGFhY2I2OThmMzgyYzgyMzQyMmIKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBF
cnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtZHdnXzljdjQvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1kZWJ1Z0BmZWRv
cmFdIEVycm9yIDIKCnJlYWwgICAgNG01MS43MTJzCnVzZXIgICAgMG05LjI5OHMKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTIyMTYx
OTUwLjI4MzktMS12c2VtZW50c292QHZpcnR1b3p6by5jb20vdGVzdGluZy5hc2FuLz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
czovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t

