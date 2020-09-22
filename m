Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F59C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 18:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36BE420756
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 18:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BE420756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKnRH-0008A1-5u
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 14:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKnPn-0007hQ-Kp
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 14:53:23 -0400
Resent-Date: Tue, 22 Sep 2020 14:53:23 -0400
Resent-Message-Id: <E1kKnPn-0007hQ-Kp@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKnPk-0004qg-Ai
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 14:53:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600800782; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=auDtMdt/gulmR0anz6asTctYxYQ4Dw9znfj7oWlBj6G+bVLoNCwHJ841IAmb+FF2mkrfpCHb72kqngSJ+UcAF76wKadBMF+3tH3aJVJZeXoOXAVEIR+F8tgIg133wikDB1TvU82sh2wzj7wnB2COfLm6wHGgOZmqS0Qzzb61CTE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600800782;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=dtjAj3yX1+7FGh2xCVbq12Bnu6sfg34dB0jIz2AMGBI=; 
 b=ESzjsp5VWw4OllOXNZh7aO+46Ibc/StxoIQq9ESPGLLgBK0bLvPSSljTXkNqN2/RwDLJ3Wpmd65yV+rRE1E7c7ghI2ECcIPnhkZqifKWeUQhdiCHTJ3+cuNdhlfFsUt3oBcA80B8jfZCae79R8Sj4Hlv5pVk3y0vL6w/dS3PZ2s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600800781802931.8763157704797;
 Tue, 22 Sep 2020 11:53:01 -0700 (PDT)
Subject: Re: [PATCH v5 00/15] Reverse debugging
Message-ID: <160080077862.1915.9166264632516049336@66eaa9a8a123>
In-Reply-To: <160077693745.10249.9707329107813662236.stgit@pasha-ThinkPad-X280>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pavel.dovgalyuk@ispras.ru
Date: Tue, 22 Sep 2020 11:53:01 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 14:49:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, pavel.dovgalyuk@ispras.ru, ehabkost@redhat.com,
 philmd@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, wrampazz@redhat.com,
 crosa@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 alex.bennee@linaro.org, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAwNzc2OTM3NDUuMTAyNDku
OTcwNzMyOTEwNzgxMzY2MjIzNi5zdGdpdEBwYXNoYS1UaGlua1BhZC1YMjgwLwoKCgpIaSwKClRo
aXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVh
c2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5
b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdAps
b2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFS
Q0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFr
ZSBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KCkhvc3QgbWFjaGluZSBjcHU6IHg4Nl82NApUYXJnZXQgbWFjaGluZSBjcHUgZmFt
aWx5OiB4ODYKVGFyZ2V0IG1hY2hpbmUgY3B1OiB4ODZfNjQKLi4vc3JjL21lc29uLmJ1aWxkOjEw
OiBXQVJOSU5HOiBNb2R1bGUgdW5zdGFibGUta2V5dmFsIGhhcyBubyBiYWNrd2FyZHMgb3IgZm9y
d2FyZHMgY29tcGF0aWJpbGl0eSBhbmQgbWlnaHQgbm90IGV4aXN0IGluIGZ1dHVyZSByZWxlYXNl
cy4KUHJvZ3JhbSBzaCBmb3VuZDogWUVTClByb2dyYW0gcHl0aG9uMyBmb3VuZDogWUVTICgvdXNy
L2Jpbi9weXRob24zKQpDb25maWd1cmluZyBuaW5qYXRvb2wgdXNpbmcgY29uZmlndXJhdGlvbgot
LS0KQ29tcGlsaW5nIEMgb2JqZWN0IGxpYnFlbXV1dGlsLmEucC9tZXNvbi1nZW5lcmF0ZWRfLi5f
dHJhY2VfdHJhY2UtaW8uYy5vYmoKQ29tcGlsaW5nIEMgb2JqZWN0IGxpYnFlbXV1dGlsLmEucC9t
ZXNvbi1nZW5lcmF0ZWRfLi5fcWFwaV9xYXBpLWNvbW1hbmRzLWJsb2NrLmMub2JqCgpXYXJuaW5n
LCB0cmVhdGVkIGFzIGVycm9yOgovdG1wL3FlbXUtdGVzdC9zcmMvZG9jcy9zeXN0ZW0vcmVwbGF5
LnJzdDo0MzpEZWZpbml0aW9uIGxpc3QgZW5kcyB3aXRob3V0IGEgYmxhbmsgbGluZTsgdW5leHBl
Y3RlZCB1bmluZGVudC4KQ29tcGlsaW5nIEMgb2JqZWN0IGxpYnFlbXV1dGlsLmEucC9tZXNvbi1n
ZW5lcmF0ZWRfLi5fcWFwaV9xYXBpLXZpc2l0LWNyeXB0by5jLm9iagpDb21waWxpbmcgQyBvYmpl
Y3QgbGlicWVtdXV0aWwuYS5wL21lc29uLWdlbmVyYXRlZF8uLl9xYXBpX3FhcGktZXZlbnRzLW1h
Y2hpbmUuYy5vYmoKLS0tCkNvbXBpbGluZyBDIG9iamVjdCBsaWJxZW11dXRpbC5hLnAvbWVzb24t
Z2VuZXJhdGVkXy4uX3FhcGlfcWFwaS1ldmVudHMtbmV0LmMub2JqCkNvbXBpbGluZyBDIG9iamVj
dCBsaWJxZW11dXRpbC5hLnAvbWVzb24tZ2VuZXJhdGVkXy4uX3FhcGlfcWFwaS1ldmVudHMtaW50
cm9zcGVjdC5jLm9iagpDb21waWxpbmcgQyBvYmplY3QgbGlicWVtdXV0aWwuYS5wL21lc29uLWdl
bmVyYXRlZF8uLl9xYXBpX3FhcGktY29tbWFuZHMtbmV0LmMub2JqCm1ha2U6ICoqKiBbTWFrZWZp
bGUubmluamE6MjI0NDogZG9jcy9zeXN0ZW0uc3RhbXBdIEVycm9yIDIKbWFrZTogKioqIERlbGV0
aW5nIGZpbGUgJ2RvY3Mvc3lzdGVtLnN0YW1wJwptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5p
c2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6Ci0tLQogICAg
cmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQ
cm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0t
cm0nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTY2YmM5MDNhZjk1NjRkNzY4
MzQ4NGEwZjlhOThhNmNkJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29t
cD11bmNvbmZpbmVkJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdV
UkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUn
LCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12Jywg
Jy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6
eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtYXJkamhtMWIvc3JjL2RvY2tl
ci1zcmMuMjAyMC0wOS0yMi0xNC40OS4zNS43MjA1Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11
L2ZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5v
bi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0
YW5jZS51dWlkPTY2YmM5MDNhZjk1NjRkNzY4MzQ4NGEwZjlhOThhNmNkCm1ha2VbMV06ICoqKiBb
ZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLWFyZGpobTFiL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRl
c3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDNtMjIuNjg0cwp1c2VyICAgIDBtMTYu
MDg3cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMTYwMDc3NjkzNzQ1LjEwMjQ5Ljk3MDczMjkxMDc4MTM2NjIyMzYuc3RnaXRAcGFzaGEtVGhp
bmtQYWQtWDI4MC90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=

