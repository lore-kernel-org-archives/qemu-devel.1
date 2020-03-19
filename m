Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0303C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9500A20714
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9500A20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEqPm-0002WV-Jh
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jEqP4-0001dt-DF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jEqP2-0003r0-Kf
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:19:46 -0400
Resent-Date: Thu, 19 Mar 2020 04:19:46 -0400
Resent-Message-Id: <E1jEqP2-0003r0-Kf@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jEqP2-0003l2-Ca
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:19:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584605973; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gJQWGnb+a3HlC3rx5TlsGEiLKnak8lTQFTTJDBpAa61BSd/mWGnwnxdPVU2RLmTL59Ihp5YZTAiOpRNoZ+fVv/wWhUszcbl2JSVqL3jkah7kgyz4tB885fDy1WryjcoNMhv8TvaojnZI/daoHxe8811b7iP1/NSIgZPbzKZpHjM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584605973;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=EyvX04ZwVlCVUui9nY28kT9L7mgFZQFdbR0aTddIhjI=; 
 b=idNIsZVmB+B1coXYugJnEArX/yBuCEk4XCEQzTauwdUNBCHEhz+N7baTTYhTJXc3e9zyZLNHsdytY6EjhFmjqtvZbhsohfBAGUmpo6blbZl7OTRF6rgaUrMya3+sb4wTDfwFT6yPbLqqdDm6rupMPKo4LYVI0hbyaokKDxHwP8I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158460597103774.74064148065338;
 Thu, 19 Mar 2020 01:19:31 -0700 (PDT)
In-Reply-To: <20200319080117.7725-1-kraxel@redhat.com>
Subject: Re: [PATCH 00/13] microvm: add acpi support
Message-ID: <158460596927.25478.2472470088925207572@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Thu, 19 Mar 2020 01:19:31 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: ehabkost@redhat.com, slp@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxOTA4MDExNy43NzI1
LTEta3JheGVsQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2Fu
IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBv
dXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFi
bHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNUPXg4
Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIEND
ICAgICAgaHcvbmV0L3Zob3N0X25ldC5vCiAgQ0MgICAgICBody9uZXQvdmhvc3RfbmV0LXN0dWIu
bwogIENDICAgICAgaHcvbmV0L3JvY2tlci9yb2NrZXIubwovdG1wL3FlbXUtdGVzdC9zcmMvaHcv
YWNwaS9pc2EtYWNwaS5jOjUyOjQ2OiBlcnJvcjogdG9vIGZldyBhcmd1bWVudHMgdG8gZnVuY3Rp
b24gY2FsbCwgZXhwZWN0ZWQgNSwgaGF2ZSA0CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmemVybywgTlVMTCk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcW9tL29iamVjdC5oOjE2ODc6MTog
bm90ZTogJ29iamVjdF9wcm9wZXJ0eV9hZGRfdWludDhfcHRyJyBkZWNsYXJlZCBoZXJlCnZvaWQg
b2JqZWN0X3Byb3BlcnR5X2FkZF91aW50OF9wdHIoT2JqZWN0ICpvYmosIGNvbnN0IGNoYXIgKm5h
bWUsCl4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkvaXNhLWFjcGkuYzo1NDo0NjogZXJyb3I6
IHRvbyBmZXcgYXJndW1lbnRzIHRvIGZ1bmN0aW9uIGNhbGwsIGV4cGVjdGVkIDUsIGhhdmUgNAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnplcm8sIE5VTEwpOwogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9p
bmNsdWRlL3FvbS9vYmplY3QuaDoxNjg3OjE6IG5vdGU6ICdvYmplY3RfcHJvcGVydHlfYWRkX3Vp
bnQ4X3B0cicgZGVjbGFyZWQgaGVyZQp2b2lkIG9iamVjdF9wcm9wZXJ0eV9hZGRfdWludDhfcHRy
KE9iamVjdCAqb2JqLCBjb25zdCBjaGFyICpuYW1lLApeCi90bXAvcWVtdS10ZXN0L3NyYy9ody9h
Y3BpL2lzYS1hY3BpLmM6NTY6NTQ6IGVycm9yOiB0b28gZmV3IGFyZ3VtZW50cyB0byBmdW5jdGlv
biBjYWxsLCBleHBlY3RlZCA1LCBoYXZlIDQKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmcy0+Z3BlX2Jhc2UsIE5VTEwpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcW9tL29i
amVjdC5oOjE3MzA6MTogbm90ZTogJ29iamVjdF9wcm9wZXJ0eV9hZGRfdWludDMyX3B0cicgZGVj
bGFyZWQgaGVyZQp2b2lkIG9iamVjdF9wcm9wZXJ0eV9hZGRfdWludDMyX3B0cihPYmplY3QgKm9i
aiwgY29uc3QgY2hhciAqbmFtZSwKXgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9pc2EtYWNw
aS5jOjU4OjUzOiBlcnJvcjogdG9vIGZldyBhcmd1bWVudHMgdG8gZnVuY3Rpb24gY2FsbCwgZXhw
ZWN0ZWQgNSwgaGF2ZSA0CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnMtPmdw
ZV9sZW4sIE5VTEwpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xb20vb2JqZWN0Lmg6MTczMDox
OiBub3RlOiAnb2JqZWN0X3Byb3BlcnR5X2FkZF91aW50MzJfcHRyJyBkZWNsYXJlZCBoZXJlCnZv
aWQgb2JqZWN0X3Byb3BlcnR5X2FkZF91aW50MzJfcHRyKE9iamVjdCAqb2JqLCBjb25zdCBjaGFy
ICpuYW1lLApeCi90bXAvcWVtdS10ZXN0L3NyYy9ody9hY3BpL2lzYS1hY3BpLmM6NjA6NTM6IGVy
cm9yOiB0b28gZmV3IGFyZ3VtZW50cyB0byBmdW5jdGlvbiBjYWxsLCBleHBlY3RlZCA1LCBoYXZl
IDQKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcy0+c2NpX2lycSwgTlVMTCk7
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90
bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3FvbS9vYmplY3QuaDoxNzA4OjE6IG5vdGU6ICdvYmpl
Y3RfcHJvcGVydHlfYWRkX3VpbnQxNl9wdHInIGRlY2xhcmVkIGhlcmUKdm9pZCBvYmplY3RfcHJv
cGVydHlfYWRkX3VpbnQxNl9wdHIoT2JqZWN0ICpvYmosIGNvbnN0IGNoYXIgKm5hbWUsCl4KL3Rt
cC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkvaXNhLWFjcGkuYzo2Mjo1MzogZXJyb3I6IHRvbyBmZXcg
YXJndW1lbnRzIHRvIGZ1bmN0aW9uIGNhbGwsIGV4cGVjdGVkIDUsIGhhdmUgNAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZzLT5pb19iYXNlLCBOVUxMKTsKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qv
c3JjL2luY2x1ZGUvcW9tL29iamVjdC5oOjE3MzA6MTogbm90ZTogJ29iamVjdF9wcm9wZXJ0eV9h
ZGRfdWludDMyX3B0cicgZGVjbGFyZWQgaGVyZQp2b2lkIG9iamVjdF9wcm9wZXJ0eV9hZGRfdWlu
dDMyX3B0cihPYmplY3QgKm9iaiwgY29uc3QgY2hhciAqbmFtZSwKXgo2IGVycm9ycyBnZW5lcmF0
ZWQuCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogaHcvYWNwaS9p
c2EtYWNwaS5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMu
Li4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2Rv
Y2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxs
ZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJv
cjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdj
b20ucWVtdS5pbnN0YW5jZS51dWlkPWFmZjYzMDY2OWNkOTQ1MWU4ZmMxMTBiMmZlNjJlZGQxJywg
Jy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0t
cm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUnLCAnLWUnLCAnRVhUUkFfQ09O
RklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9Jywg
Jy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICct
dicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2Nj
YWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC10enBheG42Mi9zcmMv
ZG9ja2VyLXNyYy4yMDIwLTAzLTE5LTA0LjE1LjI4LjE2MzYxOi92YXIvdG1wL3FlbXU6eixybycs
ICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LWRlYnVnJ10nIHJldHVy
bmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVt
dS5pbnN0YW5jZS51dWlkPWFmZjYzMDY2OWNkOTQ1MWU4ZmMxMTBiMmZlNjJlZGQxCm1ha2VbMV06
ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXR6cGF4bjYyL3NyYycKbWFrZTogKioqIFtkb2NrZXIt
cnVuLXRlc3QtZGVidWdAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDRtMC43NjZzCnVzZXIgICAg
MG04LjE1NXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMjAwMzE5MDgwMTE3Ljc3MjUtMS1rcmF4ZWxAcmVkaGF0LmNvbS90ZXN0aW5nLmFz
YW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

