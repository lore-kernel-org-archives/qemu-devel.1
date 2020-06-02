Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE66C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1307E206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1307E206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg1mT-0006v9-AF
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 03:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jg1lq-0005wg-5e
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:55:38 -0400
Resent-Date: Tue, 02 Jun 2020 03:55:38 -0400
Resent-Message-Id: <E1jg1lq-0005wg-5e@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jg1lp-0002iV-6F
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:55:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591084483; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ifq1yddshru7oebP9fhWLIIXvSepZwboEH7EcpzPcCoKQgRSs75PlJQ8c5waULNUO/m+1V0cOymMIw1NjPnIsGeEcLS41yBvit82B3cS5HjKrAhpKKXRoJQF8yy4SUN9zr6fOUAeRyDIGTosVkfvMiwEGbzRRTzzO/ephd9KP4w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591084483;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=RSxnqYEQl6FcQIbJup+BpkJAtPKuTCGDgcNc+1U/Hdk=; 
 b=OWRmh27VqWFNqVWuESL+lwaUcXV4KkIntEdi4D2GF+V0/N2IsNjQl2oPr0weNstlQ5qt9iGZaPj3IqVH0ey4ModPvmDBS/U8S4LnwrdwNkYlNtFv3IgB1qEe3JdHfeblgpyHDK0Dy/L4sDoZuilGuzdyUJeKBb+6QAkkSGRHKhs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591084481650869.1089403345936;
 Tue, 2 Jun 2020 00:54:41 -0700 (PDT)
Message-ID: <159108448058.18153.3906546977312370243@45ef0f9c86ae>
In-Reply-To: <20200602074201.10879-1-lma@suse.com>
Subject: Re: [PATCH 0/4] Add Support for GET LBA STATUS 16 command in scsi
 emulation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lma@suse.com
Date: Tue, 2 Jun 2020 00:54:41 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:52:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 lma@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwMjA3NDIwMS4xMDg3
OS0xLWxtYUBzdXNlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGFzYW4gYnVp
bGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1
dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSBy
ZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jh
c2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0
LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAg
ICBibG9jay9udm1lLm8KICBDQyAgICAgIGJsb2NrL25iZC5vCiAgQ0MgICAgICBibG9jay9zaGVl
cGRvZy5vCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9ibG9jay1iYWNrZW5kLmM6MTY2NjoxMjog
ZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdiZHJ2X2NvX2dldF9sYmFf
c3RhdHVzJyBpcyBpbnZhbGlkIGluIEM5OSBbLVdlcnJvciwtV2ltcGxpY2l0LWZ1bmN0aW9uLWRl
Y2xhcmF0aW9uXQogICAgcmV0dXJuIGJkcnZfY29fZ2V0X2xiYV9zdGF0dXMoYmxrLT5yb290LCBv
ZmZzZXQsIGJ5dGVzLCBudW1fYmxvY2tzLAogICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3Jj
L2Jsb2NrL2Jsb2NrLWJhY2tlbmQuYzoxNjY2OjEyOiBub3RlOiBkaWQgeW91IG1lYW4gJ2Jsa19k
b19nZXRfbGJhX3N0YXR1cyc/Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9ibG9jay1iYWNrZW5k
LmM6MTY1NDoxOiBub3RlOiAnYmxrX2RvX2dldF9sYmFfc3RhdHVzJyBkZWNsYXJlZCBoZXJlCmJs
a19kb19nZXRfbGJhX3N0YXR1cyhCbG9ja0JhY2tlbmQgKmJsaywgaW50NjRfdCBvZmZzZXQsIGlu
dCBieXRlcywKXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svYmxvY2stYmFja2VuZC5jOjE2NjY6
MTI6IGVycm9yOiB0aGlzIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIGlzIG5vdCBhIHByb3RvdHlwZSBb
LVdlcnJvciwtV3N0cmljdC1wcm90b3R5cGVzXQogICAgcmV0dXJuIGJkcnZfY29fZ2V0X2xiYV9z
dGF0dXMoYmxrLT5yb290LCBvZmZzZXQsIGJ5dGVzLCBudW1fYmxvY2tzLAogICAgICAgICAgIF4K
MiBlcnJvcnMgZ2VuZXJhdGVkLgptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5t
YWs6Njk6IGJsb2NrL2Jsb2NrLWJhY2tlbmQub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svaW8uYzoyMTkw
OjE6IGVycm9yOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIGZ1bmN0aW9uICdiZHJ2X2NvX2dl
dF9sYmFfc3RhdHVzJyBbLVdlcnJvciwtV21pc3NpbmctcHJvdG90eXBlc10KYmRydl9jb19nZXRf
bGJhX3N0YXR1cyhCZHJ2Q2hpbGQgKmNoaWxkLCBpbnQ2NF90IG9mZnNldCwgaW50NjRfdCBieXRl
cywKXgoxIGVycm9yIGdlbmVyYXRlZC4KbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVs
ZXMubWFrOjY5OiBibG9jay9pby5vXSBFcnJvciAxClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2Fs
bCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NSwgaW4g
PG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNz
RXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFu
ZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5p
bnN0YW5jZS51dWlkPWFhZWZmNDg2MjA2ZTQ5ZTZiNWMzMGQwZjk2ZTk5MzNhJywgJy11JywgJzEw
MDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUn
LCAnVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUnLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09Q
VFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NI
T1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9t
ZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6Jywg
Jy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1zazBnM3p6eC9zcmMvZG9ja2VyLXNy
Yy4yMDIwLTA2LTAyLTAzLjUwLjEyLjExODk1Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZl
ZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LWRlYnVnJ10nIHJldHVybmVkIG5vbi16
ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5j
ZS51dWlkPWFhZWZmNDg2MjA2ZTQ5ZTZiNWMzMGQwZjk2ZTk5MzNhCm1ha2VbMV06ICoqKiBbZG9j
a2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0
Y2hldy10ZXN0ZXItdG1wLXNrMGczenp4L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3Qt
ZGVidWdAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDRtMjguNTkycwp1c2VyICAgIDBtOC4zMzNz
CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8y
MDIwMDYwMjA3NDIwMS4xMDg3OS0xLWxtYUBzdXNlLmNvbS90ZXN0aW5nLmFzYW4vP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=

