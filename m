Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6009DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322EB20702
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322EB20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv4wa-0005EC-Au
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 14:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iv4uW-00049B-TD
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iv4uV-00070O-Bw
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:46:32 -0500
Resent-Date: Fri, 24 Jan 2020 14:46:32 -0500
Resent-Message-Id: <E1iv4uV-00070O-Bw@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21130)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iv4uV-0006y9-6y; Fri, 24 Jan 2020 14:46:31 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1579895080042314.5570224837985;
 Fri, 24 Jan 2020 11:44:40 -0800 (PST)
In-Reply-To: <20200124183113.58039-1-salvador@qindel.com>
Subject: Re: [PATCH] bsd-user: improve support for sparc syscall flags
Message-ID: <157989507891.23531.10374377357103915501@f6d1ed32ca6b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: salvador@qindel.com
Date: Fri, 24 Jan 2020 11:44:40 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, sfandino@yahoo.com, salvador@qindel.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEyNDE4MzExMy41ODAz
OS0xLXNhbHZhZG9yQHFpbmRlbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDEyNDE4MzExMy41ODAz
OS0xLXNhbHZhZG9yQHFpbmRlbC5jb20KU3ViamVjdDogW1BBVENIXSBic2QtdXNlcjogaW1wcm92
ZSBzdXBwb3J0IGZvciBzcGFyYyBzeXNjYWxsIGZsYWdzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3Fl
bXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDEyNDE4MzExMy41ODAzOS0xLXNh
bHZhZG9yQHFpbmRlbC5jb20gLT4gcGF0Y2hldy8yMDIwMDEyNDE4MzExMy41ODAzOS0xLXNhbHZh
ZG9yQHFpbmRlbC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo3NGE1NmFiIGJz
ZC11c2VyOiBpbXByb3ZlIHN1cHBvcnQgZm9yIHNwYXJjIHN5c2NhbGwgZmxhZ3MKCj09PSBPVVRQ
VVQgQkVHSU4gPT09CkVSUk9SOiBlbHNlIHNob3VsZCBmb2xsb3cgY2xvc2UgYnJhY2UgJ30nCiM0
NzogRklMRTogYnNkLXVzZXIvbWFpbi5jOjUyMDoKKyAgICAgICAgICAgIH0KKyAgICAgICAgICAg
IGVsc2UgaWYgKGJzZF90eXBlID09IHRhcmdldF9uZXRic2QpIHsKCkVSUk9SOiBlbHNlIHNob3Vs
ZCBmb2xsb3cgY2xvc2UgYnJhY2UgJ30nCiMxMDQ6IEZJTEU6IGJzZC11c2VyL21haW4uYzo1NzE6
CiAgICAgICAgICAgICB9CisgICAgICAgICAgICBlbHNlIGlmIChic2RfdHlwZSA9PSB0YXJnZXRf
bmV0YnNkKSB7CgpFUlJPUjogZWxzZSBzaG91bGQgZm9sbG93IGNsb3NlIGJyYWNlICd9JwojMTIw
OiBGSUxFOiBic2QtdXNlci9tYWluLmM6NTg3OgorICAgICAgICAgICAgfQorICAgICAgICAgICAg
ZWxzZSAgewoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTM2OiBG
SUxFOiBic2QtdXNlci9uZXRic2Qvc3lzY2FsbF9uci5oOjM3NToKKy8qXkkkTmV0QlNEOiB0cmFw
LmgsdiAxLjE4IDIwMTEvMDMvMjcgMTg6NDc6MDggbWFydGluIEV4cCAkICovJAoKRVJST1I6IGNv
ZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTQwOiBGSUxFOiBic2QtdXNlci9uZXRi
c2Qvc3lzY2FsbF9uci5oOjM3OToKKyAqXklUaGUgUmVnZW50cyBvZiB0aGUgVW5pdmVyc2l0eSBv
ZiBDYWxpZm9ybmlhLiAgQWxsIHJpZ2h0cyByZXNlcnZlZC4kCgpFUlJPUjogY29kZSBpbmRlbnQg
c2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMxNDg6IEZJTEU6IGJzZC11c2VyL25ldGJzZC9zeXNjYWxs
X25yLmg6Mzg3OgorICpeSVRoaXMgcHJvZHVjdCBpbmNsdWRlcyBzb2Z0d2FyZSBkZXZlbG9wZWQg
YnkgdGhlIFVuaXZlcnNpdHkgb2YkCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVz
ZSB0YWJzCiMxNDk6IEZJTEU6IGJzZC11c2VyL25ldGJzZC9zeXNjYWxsX25yLmg6Mzg4OgorICpe
SUNhbGlmb3JuaWEsIExhd3JlbmNlIEJlcmtlbGV5IExhYm9yYXRvcnkuJAoKRVJST1I6IGNvZGUg
aW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTc1OiBGSUxFOiBic2QtdXNlci9uZXRic2Qv
c3lzY2FsbF9uci5oOjQxNDoKKyAqXklAKCMpdHJhcC5oXkk4LjEgKEJlcmtlbGV5KSA2LzExLzkz
JAoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMxODQ6IEZJTEU6IGJzZC11c2VyL25l
dGJzZC9zeXNjYWxsX25yLmg6NDIzOgorI2RlZmluZSAgICAgICAgVEFSR0VUX05FVEJTRF9TWVND
QUxMX0cyUkZMQUcgICAweDQwMCAgIC8qIG9uIHN1Y2Nlc3MsIHJldHVybiB0byAlZzIgcmF0aGVy
IHRoYW4gbnBjICovCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMx
ODQ6IEZJTEU6IGJzZC11c2VyL25ldGJzZC9zeXNjYWxsX25yLmg6NDIzOgorI2RlZmluZV5JVEFS
R0VUX05FVEJTRF9TWVNDQUxMX0cyUkZMQUdeSTB4NDAwXkkvKiBvbiBzdWNjZXNzLCByZXR1cm4g
dG8gJWcyIHJhdGhlciB0aGFuIG5wYyAqLyQKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0
ZXJzCiMxODU6IEZJTEU6IGJzZC11c2VyL25ldGJzZC9zeXNjYWxsX25yLmg6NDI0OgorI2RlZmlu
ZSAgICAgICAgVEFSR0VUX05FVEJTRF9TWVNDQUxMX0c3UkZMQUcgICAweDgwMCAgIC8qIHVzZSAl
ZzcgYXMgYWJvdmUgKGRlcHJlY2F0ZWQpICovCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5l
dmVyIHVzZSB0YWJzCiMxODU6IEZJTEU6IGJzZC11c2VyL25ldGJzZC9zeXNjYWxsX25yLmg6NDI0
OgorI2RlZmluZV5JVEFSR0VUX05FVEJTRF9TWVNDQUxMX0c3UkZMQUdeSTB4ODAwXkkvKiB1c2Ug
JWc3IGFzIGFib3ZlIChkZXByZWNhdGVkKSAqLyQKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFj
dGVycwojMTg2OiBGSUxFOiBic2QtdXNlci9uZXRic2Qvc3lzY2FsbF9uci5oOjQyNToKKyNkZWZp
bmUgICAgICAgIFRBUkdFVF9ORVRCU0RfU1lTQ0FMTF9HNVJGTEFHICAgMHhjMDAgICAvKiB1c2Ug
JWc1IGFzIGFib3ZlIChvbmx5IEFCSSBjb21wYXRpYmxlIHdheSkgKi8KCkVSUk9SOiBjb2RlIGlu
ZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzE4NjogRklMRTogYnNkLXVzZXIvbmV0YnNkL3N5
c2NhbGxfbnIuaDo0MjU6CisjZGVmaW5lXklUQVJHRVRfTkVUQlNEX1NZU0NBTExfRzVSRkxBR15J
MHhjMDBeSS8qIHVzZSAlZzUgYXMgYWJvdmUgKG9ubHkgQUJJIGNvbXBhdGlibGUgd2F5KSAqLyQK
CnRvdGFsOiAxMyBlcnJvcnMsIDEgd2FybmluZ3MsIDE1MyBsaW5lcyBjaGVja2VkCgpDb21taXQg
NzRhNTZhYmVjMTU1IChic2QtdXNlcjogaW1wcm92ZSBzdXBwb3J0IGZvciBzcGFyYyBzeXNjYWxs
IGZsYWdzKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDEyNDE4MzExMy41ODAzOS0xLXNhbHZh
ZG9yQHFpbmRlbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

