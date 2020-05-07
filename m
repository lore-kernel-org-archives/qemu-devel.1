Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB20C28CBC
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 01:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE5C62075A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 01:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5C62075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWVCV-00081c-1b
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 21:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jWVBw-0007bJ-Lq
 for qemu-devel@nongnu.org; Wed, 06 May 2020 21:19:12 -0400
Resent-Date: Wed, 06 May 2020 21:19:12 -0400
Resent-Message-Id: <E1jWVBw-0007bJ-Lq@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jWVBu-0006aI-DN
 for qemu-devel@nongnu.org; Wed, 06 May 2020 21:19:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588814336; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PRtOOdNSSnjzxT7utluqG4FVsZkfrFZeGc5SrrJsVCQ9itD0bnVUq9+4wxsZSbTE/aVYBghs9boBqTRNhiCKove1O/ZltlC0jLbkhRrZT8ZaPP8B9q3O4Y0rNMxm5IiGmoc6ZLnxSfZVv2JnOg0j3vLuUh6SNitTJARhlhGbTX8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588814336;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=y+ANir1dmS74Qkj5rkf9J02p/y2hbxRskBIMBl2gTNk=; 
 b=af/UUCI+JDSbxWi/df0FVa3ueEAeTk6mcBH3ZYQurG/JYaz3x+n8QEYqt6PLyWssRd1DrU182Icl+KJUR4YT9mDYrLAAmE2qHOeEvr2ZgZxTd9NfFoKBSoilOS+RUOqK9ZkdyRo7xC3mDHl3kc6FP73X/xhJfIj/5snr3E/Xd7c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588814335089496.66373795002016;
 Wed, 6 May 2020 18:18:55 -0700 (PDT)
Message-ID: <158881433378.4109.8050789554490153706@45ef0f9c86ae>
In-Reply-To: <20200507005234.959590-1-andrew@daynix.com>
Subject: Re: [PATCH] hw/net: Added basic IPv6 fragmentation. Fixed IPv6
 payload length. Fixed CSO for IPv6.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrew@daynix.com
Date: Wed, 6 May 2020 18:18:55 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 21:19:06
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
Cc: jasowang@redhat.com, dmitry.fleytman@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwNzAwNTIzNC45NTk1
OTAtMS1hbmRyZXdAZGF5bml4LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGFz
YW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWly
IG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9i
YWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9
eDg2XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAg
Q0MgICAgICBody9wY2kvcGNpX2hvc3QubwogIENDICAgICAgaHcvcGNpL3BjaWVfYWVyLm8KICBD
QyAgICAgIGh3L3BjaS9wY2llLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L25ldC9uZXRfdHhfcGt0
LmM6NDg2OjE2OiBlcnJvcjogdmFyaWFibGUgJ2NzbycgaXMgdXNlZCB1bmluaXRpYWxpemVkIHdo
ZW5ldmVyICdpZicgY29uZGl0aW9uIGlzIGZhbHNlIFstV2Vycm9yLC1Xc29tZXRpbWVzLXVuaW5p
dGlhbGl6ZWRdCiAgICB9IGVsc2UgaWYgKGwzX3Byb3RvID09IEVUSF9QX0lQVjYpIHsKICAgICAg
ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvbmV0
L25ldF90eF9wa3QuYzo0OTQ6NzU6IG5vdGU6IHVuaW5pdGlhbGl6ZWQgdXNlIG9jY3VycyBoZXJl
Ci0tLQogICAgICAgICAgICAgICAgXgogICAgICAgICAgICAgICAgID0gMAoxIGVycm9yIGdlbmVy
YXRlZC4KbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBody9uZXQv
bmV0X3R4X3BrdC5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpv
YnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3Rz
L2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBD
YWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NF
cnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcs
ICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWUxNTRkNjUxYzU2NTQ1YTg4OTE3YjkxMTc3MWYyZjIy
JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywg
Jy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUnLCAnLWUnLCAnRVhUUkFf
Q09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9
JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScs
ICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1w
L2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1nMnE3Y3JkNC9z
cmMvZG9ja2VyLXNyYy4yMDIwLTA1LTA2LTIxLjE0LjQ4LjE0NTM6L3Zhci90bXAvcWVtdTp6LHJv
JywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtZGVidWcnXScgcmV0
dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9ZTE1NGQ2NTFjNTY1NDVhODg5MTdiOTExNzcxZjJmMjIKbWFrZVsx
XTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZzJxN2NyZDQvc3JjJwptYWtlOiAqKiogW2RvY2tl
ci1ydW4tdGVzdC1kZWJ1Z0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgNG01LjgzMnMKdXNlciAg
ICAwbTguNjI0cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAyMDA1MDcwMDUyMzQuOTU5NTkwLTEtYW5kcmV3QGRheW5peC5jb20vdGVzdGlu
Zy5hc2FuLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

