Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3A1C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B0420776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B0420776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdX7t-00072Y-7G
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdX6u-0005z4-TM; Tue, 26 May 2020 06:47:05 -0400
Resent-Date: Tue, 26 May 2020 06:47:04 -0400
Resent-Message-Id: <E1jdX6u-0005z4-TM@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdX6r-0001zJ-Tn; Tue, 26 May 2020 06:47:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590490006; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WLk7Ier/d/lf4+rtBstY6hCEF7e8jrDmEUMjM7DInEMkr0f3aZFNko6Vlc+IGD1id8Runbxqu9ZLuZoN5naiyG2B1i1icIQsL6bZFS27udidsDOFeXejkXQTipAmMTSkijlPbVZ8J3nGYP+wDCdcNHX0beootlY5JIZqHRc6LCg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590490006;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=dRYlgM5UhPZ34Aq+2hzTqtuzAqSNICP2teKQYH6HBjo=; 
 b=mzWBZRy3WFqMU0KR7BClX7Wq9Dr8SjsV/zZFFpg4HarJZD4wyNCAAP26KbVGQNE+u2oMWrlPLFClyVGWnzkg4WEEwdt9zWSG0ONQVggRFLJYSmfTtEe04/81OpE4499kLLdnYA5NH68SuOAMZfklRdOdVnvVWWhD8ErRVtLnTdA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590490004082226.4315842797712;
 Tue, 26 May 2020 03:46:44 -0700 (PDT)
Message-ID: <159049000222.9494.6642161589736904677@45ef0f9c86ae>
In-Reply-To: <20200526081740.256236-1-rvkagan@yandex-team.ru>
Subject: Re: [PATCH v5 0/5] block: widen and check consistency of size-related
 BlockConf properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: rvkagan@yandex-team.ru
Date: Tue, 26 May 2020 03:46:44 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:17:51
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
Cc: kwolf@redhat.com, fam@euphon.net, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, kraxel@redhat.com,
 stefanha@redhat.com, kbusch@kernel.org, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyNjA4MTc0MC4yNTYy
MzYtMS1ydmthZ2FuQHlhbmRleC10ZWFtLnJ1LwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgYXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQK
dGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2Fu
IHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3Jh
IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRf
TElTVD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKICBDQyAgICAgIGh3L2Rpc3BsYXkvcmFtZmItc3RhbmRhbG9uZS5vCiAgQ0MgICAgICBody9k
aXNwbGF5L2NpcnJ1c192Z2EubwogIENDICAgICAgaHcvZGlzcGxheS9jaXJydXNfdmdhX2lzYS5v
Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay94ZW4tYmxvY2suYzoyNDI6Mjg6IGVycm9yOiB0
b28gZmV3IGFyZ3VtZW50cyB0byBmdW5jdGlvbiBjYWxsLCBleHBlY3RlZCAyLCBoYXZlIDEKICAg
IGJsa2NvbmZfYmxvY2tzaXplcyhjb25mKTsKICAgIH5+fn5+fn5+fn5+fn5+fn5+fiAgICAgXgov
dG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9ody9ibG9jay9ibG9jay5oOjkwOjE6IG5vdGU6ICdi
bGtjb25mX2Jsb2Nrc2l6ZXMnIGRlY2xhcmVkIGhlcmUKYm9vbCBibGtjb25mX2Jsb2Nrc2l6ZXMo
QmxvY2tDb25mICpjb25mLCBFcnJvciAqKmVycnApOwpeCi91c3IvbGliNjQvY2xhbmcvOC4wLjAv
aW5jbHVkZS9zdGRib29sLmg6MzE6MTQ6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ2Jvb2wn
CiNkZWZpbmUgYm9vbCBfQm9vbAogICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaHcv
YmxvY2sveGVuLWJsb2NrLmM6MjYwOjM1OiBlcnJvcjogZm9ybWF0IHNwZWNpZmllcyB0eXBlICd1
bnNpZ25lZCBpbnQnIGJ1dCB0aGUgYXJndW1lbnQgaGFzIHR5cGUgJ3VpbnQ2NF90JyAoYWthICd1
bnNpZ25lZCBsb25nJykgWy1XZXJyb3IsLVdmb3JtYXRdCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjb25mLT5kaXNjYXJkX2dyYW51bGFyaXR5KTsKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qv
c3JjL2h3L2Jsb2NrL3hlbi1ibG9jay5jOjI3NDozMTogZXJyb3I6IGZvcm1hdCBzcGVjaWZpZXMg
dHlwZSAndW5zaWduZWQgaW50JyBidXQgdGhlIGFyZ3VtZW50IGhhcyB0eXBlICd1aW50NjRfdCcg
KGFrYSAndW5zaWduZWQgbG9uZycpIFstV2Vycm9yLC1XZm9ybWF0XQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb25mLT5sb2dpY2FsX2Jsb2NrX3NpemUpOwogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KMyBlcnJvcnMgZ2VuZXJhdGVk
LgogIENDICAgICAgaHcvZGlzcGxheS94ZW5mYi5vCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qv
c3JjL3J1bGVzLm1hazo2OTogaHcvYmxvY2sveGVuLWJsb2NrLm9dIEVycm9yIDEKbWFrZTogKioq
IFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBj
YWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBp
biA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQp
CnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAn
ZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NTFjMzNm
ZGQxYjAwNGJkN2FlYTMyYmNiY2Y2MjdjZWQnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9w
dCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD14ODZf
NjQtc29mdG1tdScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAn
LWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0ND
QUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3Fl
bXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRj
aGV3LXRlc3Rlci10bXAtZGlpMjlmNXAvc3JjL2RvY2tlci1zcmMuMjAyMC0wNS0yNi0wNi40My4w
Ni4yNjE5NTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVt
dS9ydW4nLCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpm
aWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD01MWMzM2ZkZDFiMDA0
YmQ3YWVhMzJiY2JjZjYyN2NlZAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFr
ZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1kaWky
OWY1cC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LWRlYnVnQGZlZG9yYV0gRXJyb3Ig
MgoKcmVhbCAgICAzbTM2LjkwNnMKdXNlciAgICAwbTkuMTQ1cwoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MjYwODE3NDAuMjU2MjM2
LTEtcnZrYWdhbkB5YW5kZXgtdGVhbS5ydS90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=

