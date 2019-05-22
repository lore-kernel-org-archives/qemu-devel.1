Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E960DC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DBEC217D4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkgPzL6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBEC217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40540 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTPRq-0007Nn-SD
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 07:30:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTPQn-0006wS-N9
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTPQm-0007u2-9U
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:29:13 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:38665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTPQm-0007qw-03
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:29:12 -0400
Received: by mail-yb1-xb43.google.com with SMTP id x7so721721ybg.5
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 04:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language;
	bh=QuUDAnBK183O2VHsr0eqBA2dCFeq0K/DWSQdFs6FIrU=;
	b=TkgPzL6AUj47AHDaMgXOafS/c7Np3s48/R7cUFgGn0yNh9ztqieeZu5Mu3uhI4EOJy
	kBxt4hD4Ohzw+RElklBq8LMEyJP9ahhlQHDK2rRQIo4DNUo0/Dc+s+r9DpB9F4tfKVzz
	KE0L/umhCVk7I+O+b5kvX+vwvwqggH2MQbwg8dzGJu8uh4RrRZHi59lZcwyMa4L78si7
	RZ7ba+rbvu3SPH5GYE0yN6SoHFzF63hYlgO5XrQrX82lzzy+JElnKtjcZD8DhFDB0ArU
	AuxWlFawBQ5pops4BpgqHxCFNcmg9rcDM9c4cxpZzDa3PUnWzG8iT1lrbZmvflsUfuKP
	dcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language;
	bh=QuUDAnBK183O2VHsr0eqBA2dCFeq0K/DWSQdFs6FIrU=;
	b=nFTyk98yTXz4YBckkt8wmdpARHbUb0d8CMe5ciZW1/rF4WAXjjqFd9kS/sT4t0cfTP
	PiBzrtRqiDuAlLFuf2vfN1rNJlqaCtTBxbM2/Z6rKm85GtJ3tnkwehnPJlEC96cZ1Jew
	6IeqfdBTPuo9UBQgw39EdLBC0AisD5n9inhFEs3WNFYIUBcN/byQXqRpVt4GhqMLQVj+
	nA46L5hC5AmgIGB7HpcDmjWywh3nVdpTaV9Qr7+prMgieUAYmZEkLirkrIt4NmcHO3mD
	fy86uF9o5mANu6JIioYBQ1Wcl4AcGb3lcivhy+dBA93rHjG2oB0GdYMpfxRir0b+Efd7
	gchg==
X-Gm-Message-State: APjAAAUqDgVLAYIkUPnMLCP6nwTeIJ40LMBVNrcU7WGkr2IVHNY8S1Yk
	zci7sgalA2mcS55Fg7HgTLe3bWja2Mk=
X-Google-Smtp-Source: APXvYqxXt49gQAIU6H1wnZBvg03sWgxmewXEItXBo9Ctmv3NA2CVgMdUUEXJp+SNcBt/6rbtxaDyDQ==
X-Received: by 2002:a25:2:: with SMTP id 2mr19351744yba.516.1558524550620;
	Wed, 22 May 2019 04:29:10 -0700 (PDT)
Received: from [10.243.202.139] ([71.46.56.72])
	by smtp.gmail.com with ESMTPSA id
	u73sm5671295ywf.62.2019.05.22.04.29.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 04:29:09 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	qemu-devel <qemu-devel@nongnu.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
	<CAL1e-=hd+nuZmKms9AmCn8B4UqJ1M3D8A=WvbaM-UwpumkD4vQ@mail.gmail.com>
	<CAL1e-=i_=EQ02A1DGmVgqNi1ik=h39FZTOsxkGWfMa4ZoM6rjg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b367612d-8113-e342-8843-7db1a1a7dd0f@linaro.org>
Date: Wed, 22 May 2019 07:29:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i_=EQ02A1DGmVgqNi1ik=h39FZTOsxkGWfMa4ZoM6rjg@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------E191AF91AB530FB04C3875E9"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: Re: [Qemu-devel] [PATCH v7 00/74] linux-user: Split do_syscall
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------E191AF91AB530FB04C3875E9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

[Adding the mailing list back in.]

On 5/22/19 2:47 AM, Aleksandar Markovic wrote:
>> > Version 6 was
>> > https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg04794.html
>> >
>> > Since v5, I've fixed the ioctl failure that Laurent found, and
>> > have done a few more syscalls.
>> >
>> > I've tried to do more testing with LTP....
> 
> Running LTP is certainly a very important way of testing this series. However,
> it is not sufficient. This is because this series completely replaces internal
> QEMU strace mechanism for involved system calls,

What you missed because of the very large time lag between iterations, and
because I was lazy and only referenced v6 in this cover letter, is that in an
early revision the major objection was that I *wasn't* replacing strace, and
thus we were retaining lots of duplicate logic in multiple places.


> and any bug in such
> replacement would not be captured by LTP results. How did you test new strace
> bits and peaces? Can you provide logs of such tests (for example, before/after
> comparisons of strace output for relevant system calls, or similar)?

My strace testing is totally ad-hoc.  Run something with -strace and eyeball it.

Here are before/after logs for busybox ls (aka linux-user-test-0.3, which has
for some reason vanished from the qemu wiki?) for alpha-linux-user.

--------------E191AF91AB530FB04C3875E9
Content-Type: text/plain; charset=UTF-8;
 name="ls-strace-before"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ls-strace-before"

NjU3IHVuYW1lKDB4NDAwMDgwMTRiOCkgPSAwCjY1NyBicmsoTlVMTCkgPSAweDAwMDAwMDAx
MjAwNmEwMDAKNjU3IGFjY2VzcygiL2V0Yy9sZC5zby5ub2h3Y2FwIixGX09LKSA9IC0xIGVy
cm5vPTIgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCjY1NyBtbWFwKE5VTEwsODE5MixQ
Uk9UX1JFQUR8UFJPVF9XUklURSxNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLC0xLDApID0g
MHgwMDAwMDA0MDAwODJlMDAwCjY1NyBhY2Nlc3MoIi9ldGMvbGQuc28ucHJlbG9hZCIsUl9P
SykgPSAtMSBlcnJubz0yIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQo2NTcgb3Blbigi
L2V0Yy9sZC5zby5jYWNoZSIsT19SRE9OTFkpID0gMwo2NTcgZnN0YXQ2NCgzLDB4MDAwMDAw
NDAwMDgwMGMzMCkgPSAwCjY1NyBjbG9zZSgzKSA9IDAKNjU3IG9wZW4oIi9saWIvdGxzL2xp
YmMuc28uNi4xIixPX1JET05MWSkgPSAtMSBlcnJubz0yIChObyBzdWNoIGZpbGUgb3IgZGly
ZWN0b3J5KQo2NTcgc3RhdDY0KCIvbGliL3RscyIsMHgwMDAwMDA0MDAwODAwYmIwKSA9IC0x
IGVycm5vPTIgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCjY1NyBvcGVuKCIvbGliL2xp
YmMuc28uNi4xIixPX1JET05MWSkgPSAzCjY1NyByZWFkKDMsMHg4MDBkYTgsNjQwKSA9IDY0
MAo2NTcgZnN0YXQ2NCgzLDB4MDAwMDAwNDAwMDgwMGMzMCkgPSAwCjY1NyBtbWFwKE5VTEws
OTI3ODI0LFBST1RfRVhFQ3xQUk9UX1JFQUQsTUFQX1BSSVZBVEV8TUFQX0RFTllXUklURSwz
LDApID0gMHgwMDAwMDA0MDAwODMwMDAwCjY1NyBtcHJvdGVjdCgweDAwMDAwMDQwMDA4ZjIw
MDAsMTMzMjAwLFBST1RfTk9ORSkgPSAwCjY1NyBtbWFwKDB4MDAwMDAwNDAwMDkwMjAwMCw2
NTUzNixQUk9UX0VYRUN8UFJPVF9SRUFEfFBST1RfV1JJVEUsTUFQX1BSSVZBVEV8TUFQX0RF
TllXUklURXxNQVBfRklYRUQsMywweGMyMDAwKSA9IDB4MDAwMDAwNDAwMDkwMjAwMAo2NTcg
bW1hcCgweDAwMDAwMDQwMDA5MTIwMDAsMjEyOCxQUk9UX0VYRUN8UFJPVF9SRUFEfFBST1Rf
V1JJVEUsTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9VU3xNQVBfRklYRUQsLTEsMCkgPSAweDAw
MDAwMDQwMDA5MTIwMDAKNjU3IGNsb3NlKDMpID0gMAo2NTcgbXByb3RlY3QoMHgwMDAwMDA0
MDAwODJhMDAwLDgxOTIsUFJPVF9SRUFEKSA9IDAKNjU3IGdldHh1aWQoMjc0ODg2MzAyMDk4
LDQ4MzIxMTIxNDMsNzcsMjQsNDgzMTg1OTc0NCwyNzQ4ODYzNTY4NjQpID0gMTAwMAo2NTcg
Z2V0eGdpZCgyNzQ4ODYzMDIwOTgsNDgzMjExMjE0Myw3NywwLDEwMDAsMjc0ODg2MzU2ODY0
KSA9IDEwMDAKNjU3IHNldGdpZCgxMDAwLDQ4MzIxMTIxNDMsNzcsMCwxMDAwLDI3NDg4NjM1
Njg2NCkgPSAwCjY1NyBzZXR1aWQoMTAwMCw0ODMyMTEyMTQzLDc3LDAsMTAwMCwyNzQ4ODYz
NTY4NjQpID0gMAo2NTcgaW9jdGwoMSwxMDc0Mjk1OTEyLDI3NDg4NjMwMTA3MiwwLDEwMDAs
Mjc0ODg2MzU2ODY0KSA9IDAKNjU3IGxzdGF0NjQoImR1bW15ZmlsZSIsMHgwMDAwMDA0MDAw
ODAxNTEwKSA9IDAKNjU3IGJyayhOVUxMKSA9IDB4MDAwMDAwMDEyMDA2YTAwMAo2NTcgYnJr
KDB4MDAwMDAwMDEyMDA4YzAwMCkgPSAweDAwMDAwMDAxMjAwOGMwMDAKNjU3IG9wZW4oIi9l
dGMvbG9jYWx0aW1lIixPX1JET05MWSkgPSAzCjY1NyBmc3RhdDY0KDMsMHgwMDAwMDA0MDAw
ODAxMzYwKSA9IDAKNjU3IGZzdGF0NjQoMywweDAwMDAwMDQwMDA4MDExZjApID0gMAo2NTcg
bW1hcChOVUxMLDgxOTIsUFJPVF9SRUFEfFBST1RfV1JJVEUsTUFQX1BSSVZBVEV8TUFQX0FO
T05ZTU9VUywtMSwwKSA9IDB4MDAwMDAwNDAwMDkxNDAwMAo2NTcgcmVhZCgzLDB4OTE0MDAw
LDQwOTYpID0gMzU0NQo2NTcgY2xvc2UoMykgPSAwCjY1NyBtdW5tYXAoMHgwMDAwMDA0MDAw
OTE0MDAwLDgxOTIpID0gMAo2NTcgZnN0YXQ2NCgxLDB4MDAwMDAwNDAwMDgwMGM3MCkgPSAw
CjY1NyBtbWFwKE5VTEwsODE5MixQUk9UX1JFQUR8UFJPVF9XUklURSxNQVBfUFJJVkFURXxN
QVBfQU5PTllNT1VTLC0xLDApID0gMHgwMDAwMDA0MDAwOTE2MDAwCjY1NyBvcGVuKCIvZXRj
L3Bhc3N3ZCIsT19SRE9OTFkpID0gMwo2NTcgZnN0YXQ2NCgzLDB4MDAwMDAwNDAwMDgwMTI5
MCkgPSAwCjY1NyBtbWFwKE5VTEwsODE5MixQUk9UX1JFQUR8UFJPVF9XUklURSxNQVBfUFJJ
VkFURXxNQVBfQU5PTllNT1VTLC0xLDApID0gMHgwMDAwMDA0MDAwOTE4MDAwCjY1NyByZWFk
KDMsMHg5MTgwMDAsNDA5NikgPSAyNzI3CjY1NyBjbG9zZSgzKSA9IDAKNjU3IG11bm1hcCgw
eDAwMDAwMDQwMDA5MTgwMDAsODE5MikgPSAwCjY1NyBvcGVuKCIvZXRjL2dyb3VwIixPX1JE
T05MWSkgPSAzCjY1NyBmc3RhdDY0KDMsMHgwMDAwMDA0MDAwODAxMjkwKSA9IDAKNjU3IG1t
YXAoTlVMTCw4MTkyLFBST1RfUkVBRHxQUk9UX1dSSVRFLE1BUF9QUklWQVRFfE1BUF9BTk9O
WU1PVVMsLTEsMCkgPSAweDAwMDAwMDQwMDA5MWEwMDAKNjU3IHJlYWQoMywweDkxYTAwMCw0
MDk2KSA9IDEwNDMKNjU3IGNsb3NlKDMpID0gMAo2NTcgbXVubWFwKDB4MDAwMDAwNDAwMDkx
YTAwMCw4MTkyKSA9IDAKNjU3IGdldHRpbWVvZmRheSgyNzQ4ODYzMDA5MTIsMCwxLDAsMTAz
LDEwMjQpID0gMAo2NTcgd3JpdGUoMSwweDkxNjAwMCw2NikgPSA2Ngo2NTcgbXVubWFwKDB4
MDAwMDAwNDAwMDkxNjAwMCw4MTkyKSA9IDAKNjU3IGV4aXRfZ3JvdXAoMCkK
--------------E191AF91AB530FB04C3875E9
Content-Type: text/plain; charset=UTF-8;
 name="ls-strace-after"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ls-strace-after"

MTc4NjIgdW5hbWUoMHg0MDAwODAxNGI4KSA9IDAKMTc4NjIgYnJrKE5VTEwpID0gMHgwMDAw
MDAwMTIwMDZhMDAwCjE3ODYyIGFjY2VzcygiL2V0Yy9sZC5zby5ub2h3Y2FwIiwgRl9PSykg
PSAtMSBlcnJubz0yIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQoxNzg2MiBtbWFwKE5V
TEwsIDgxOTIsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfQU5PTllN
T1VTLCAtMSwgMCkgPSAweDAwMDAwMDQwMDA4MmUwMDAKMTc4NjIgYWNjZXNzKCIvZXRjL2xk
LnNvLnByZWxvYWQiLCBSX09LKSA9IC0xIGVycm5vPTIgKE5vIHN1Y2ggZmlsZSBvciBkaXJl
Y3RvcnkpCjE3ODYyIG9wZW4oIi9ldGMvbGQuc28uY2FjaGUiLCBPX1JET05MWSwgMDEpID0g
MwoxNzg2MiBmc3RhdDY0KDMsMHgwMDAwMDA0MDAwODAwYzMwKSA9IDAKMTc4NjIgY2xvc2Uo
MykgPSAwCjE3ODYyIG9wZW4oIi9saWIvdGxzL2xpYmMuc28uNi4xIiwgT19SRE9OTFksIDAx
NCkgPSAtMSBlcnJubz0yIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQoxNzg2MiBzdGF0
NjQoIi9saWIvdGxzIiwweDAwMDAwMDQwMDA4MDBiYjApID0gLTEgZXJybm89MiAoTm8gc3Vj
aCBmaWxlIG9yIGRpcmVjdG9yeSkKMTc4NjIgb3BlbigiL2xpYi9saWJjLnNvLjYuMSIsIE9f
UkRPTkxZLCAwMTQpID0gMwoxNzg2MiByZWFkKDMsIDB4MDAwMDAwNDAwMDgwMGRhOCwgNjQw
KSA9IDY0MAoxNzg2MiBmc3RhdDY0KDMsMHgwMDAwMDA0MDAwODAwYzMwKSA9IDAKMTc4NjIg
bW1hcChOVUxMLCA5Mjc4MjQsIFBST1RfRVhFQ3xQUk9UX1JFQUQsIE1BUF9QUklWQVRFfE1B
UF9ERU5ZV1JJVEUsIDMsIDApID0gMHgwMDAwMDA0MDAwODMwMDAwCjE3ODYyIG1wcm90ZWN0
KDB4MDAwMDAwNDAwMDhmMjAwMCwgMTMzMjAwLCBQUk9UX05PTkUpID0gMAoxNzg2MiBtbWFw
KDB4MDAwMDAwNDAwMDkwMjAwMCwgNjU1MzYsIFBST1RfRVhFQ3xQUk9UX1JFQUR8UFJPVF9X
UklURSwgTUFQX1BSSVZBVEV8TUFQX0RFTllXUklURXxNQVBfRklYRUQsIDMsIDc5NDYyNCkg
PSAweDAwMDAwMDQwMDA5MDIwMDAKMTc4NjIgbW1hcCgweDAwMDAwMDQwMDA5MTIwMDAsIDIx
MjgsIFBST1RfRVhFQ3xQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0FO
T05ZTU9VU3xNQVBfRklYRUQsIC0xLCAwKSA9IDB4MDAwMDAwNDAwMDkxMjAwMAoxNzg2MiBj
bG9zZSgzKSA9IDAKMTc4NjIgbXByb3RlY3QoMHgwMDAwMDA0MDAwODJhMDAwLCA4MTkyLCBQ
Uk9UX1JFQUQpID0gMAoxNzg2MiBnZXR4dWlkKDI3NDg4NjMwMjA5OCw0ODMyMTEyMTQzLDc3
LDI0LDQ4MzE4NTk3NDQsMjc0ODg2MzU2ODY0KSA9IDEwMDAKMTc4NjIgZ2V0eGdpZCgyNzQ4
ODYzMDIwOTgsNDgzMjExMjE0Myw3NywwLDEwMDAsMjc0ODg2MzU2ODY0KSA9IDEwMDAKMTc4
NjIgc2V0Z2lkKDEwMDAsNDgzMjExMjE0Myw3NywwLDEwMDAsMjc0ODg2MzU2ODY0KSA9IDAK
MTc4NjIgc2V0dWlkKDEwMDAsNDgzMjExMjE0Myw3NywwLDEwMDAsMjc0ODg2MzU2ODY0KSA9
IDAKMTc4NjIgaW9jdGwoMSwgNDAwODc0NjgpID0gMAoxNzg2MiBsc3RhdDY0KCJkdW1teWZp
bGUiLDB4MDAwMDAwNDAwMDgwMTUxMCkgPSAwCjE3ODYyIGJyayhOVUxMKSA9IDB4MDAwMDAw
MDEyMDA2YTAwMAoxNzg2MiBicmsoMHgwMDAwMDAwMTIwMDhjMDAwKSA9IDB4MDAwMDAwMDEy
MDA4YzAwMAoxNzg2MiBvcGVuKCIvZXRjL2xvY2FsdGltZSIsIE9fUkRPTkxZLCAwNjY2KSA9
IDMKMTc4NjIgZnN0YXQ2NCgzLDB4MDAwMDAwNDAwMDgwMTM2MCkgPSAwCjE3ODYyIGZzdGF0
NjQoMywweDAwMDAwMDQwMDA4MDExZjApID0gMAoxNzg2MiBtbWFwKE5VTEwsIDgxOTIsIFBS
T1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCkg
PSAweDAwMDAwMDQwMDA5MTQwMDAKMTc4NjIgcmVhZCgzLCAweDAwMDAwMDQwMDA5MTQwMDAs
IDQwOTYpID0gMzU0NQoxNzg2MiBjbG9zZSgzKSA9IDAKMTc4NjIgbXVubWFwKDB4MDAwMDAw
NDAwMDkxNDAwMCwgODE5MikgPSAwCjE3ODYyIGZzdGF0NjQoMSwweDAwMDAwMDQwMDA4MDBj
NzApID0gMAoxNzg2MiBtbWFwKE5VTEwsIDgxOTIsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBN
QVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCkgPSAweDAwMDAwMDQwMDA5MTYwMDAK
MTc4NjIgb3BlbigiL2V0Yy9wYXNzd2QiLCBPX1JET05MWSwgMDY2NikgPSAzCjE3ODYyIGZz
dGF0NjQoMywweDAwMDAwMDQwMDA4MDEyOTApID0gMAoxNzg2MiBtbWFwKE5VTEwsIDgxOTIs
IFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwg
MCkgPSAweDAwMDAwMDQwMDA5MTgwMDAKMTc4NjIgcmVhZCgzLCAweDAwMDAwMDQwMDA5MTgw
MDAsIDQwOTYpID0gMjcyNwoxNzg2MiBjbG9zZSgzKSA9IDAKMTc4NjIgbXVubWFwKDB4MDAw
MDAwNDAwMDkxODAwMCwgODE5MikgPSAwCjE3ODYyIG9wZW4oIi9ldGMvZ3JvdXAiLCBPX1JE
T05MWSwgMDY2NikgPSAzCjE3ODYyIGZzdGF0NjQoMywweDAwMDAwMDQwMDA4MDEyOTApID0g
MAoxNzg2MiBtbWFwKE5VTEwsIDgxOTIsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJ
VkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCkgPSAweDAwMDAwMDQwMDA5MWEwMDAKMTc4NjIg
cmVhZCgzLCAweDAwMDAwMDQwMDA5MWEwMDAsIDQwOTYpID0gMTA0MwoxNzg2MiBjbG9zZSgz
KSA9IDAKMTc4NjIgbXVubWFwKDB4MDAwMDAwNDAwMDkxYTAwMCwgODE5MikgPSAwCjE3ODYy
IGdldHRpbWVvZmRheSgweDAwMDAwMDQwMDA4MDE0ZjApID0gMAoxNzg2MiB3cml0ZSgxLCAw
eDAwMDAwMDQwMDA5MTYwMDAsIDY2KSA9IDY2CjE3ODYyIG11bm1hcCgweDAwMDAwMDQwMDA5
MTYwMDAsIDgxOTIpID0gMAoxNzg2MiBleGl0X2dyb3VwKDApCg==
--------------E191AF91AB530FB04C3875E9--

