Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75029C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED562483E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxfYH9cY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED562483E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSLN2-0002Xa-DZ
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSLLN-0001a0-4X
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:32:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSLLK-0001mO-10
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602599516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=h7kiDp+ZR4B/NYa/aA1Yg7yLfPIWe/BnaCC9s1CPqJk=;
 b=TxfYH9cYnYacdQ+1KRhJIT6VbcmGSo72hngYJZuOCIkHECcVMLKnOjGxi0nQVzXqGR6imb
 g8hC9sbvtd9nYNPmfuYg6B2JTLIKod/DjTeqzg60vauqWVUPG2aWeaWwgNd7kywtaFDJPd
 WqML9RGR/g2GzY6kpcPbzAGrDNyHH6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-phtvy9L0OhGDTxtfccCfgg-1; Tue, 13 Oct 2020 10:31:54 -0400
X-MC-Unique: phtvy9L0OhGDTxtfccCfgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32F1C80ED9A;
 Tue, 13 Oct 2020 14:31:51 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.193.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B52178800;
 Tue, 13 Oct 2020 14:31:48 +0000 (UTC)
Subject: Re: [PATCH qemu 4/4] iotests: add test for bitmap mirror
To: =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>,
 qemu-devel@nongnu.org
References: <20200922091418.53562-1-f.gruenbichler@proxmox.com>
 <20200922091418.53562-5-f.gruenbichler@proxmox.com>
 <5336db8d-b54a-0881-5675-ca23f9645e65@redhat.com>
 <1601624180.56wvsjysei.astroid@nora.none>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <d3e65efe-caac-fffb-f846-a5467f8c9462@redhat.com>
Date: Tue, 13 Oct 2020 16:31:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1601624180.56wvsjysei.astroid@nora.none>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GvqSIWW58nH45798bEILAsteJ2znMxVB3"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GvqSIWW58nH45798bEILAsteJ2znMxVB3
Content-Type: multipart/mixed; boundary="Yx8YgQfaRJjzzWV9Fgb1dcESM3n7FbvNA"

--Yx8YgQfaRJjzzWV9Fgb1dcESM3n7FbvNA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.10.20 10:23, Fabian Gr=C3=BCnbichler wrote:
> On October 1, 2020 7:31 pm, Max Reitz wrote:
>> On 22.09.20 11:14, Fabian Gr=C3=BCnbichler wrote:
>>> heavily based on/practically forked off iotest 257 for bitmap backups,
>>> but:
>>>
>>> - no writes to filter node 'mirror-top' between completion and
>>> finalization, as those seem to deadlock?
>>> - no inclusion of not-yet-available full/top sync modes in combination
>>> with bitmaps
>>> - extra set of reference/test mirrors to verify that writes in parallel
>>> with active mirror work
>>>
>>> intentionally keeping copyright and ownership of original test case to
>>> honor provenance.
>>>
>>> Signed-off-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>
>>> ---
>>>  tests/qemu-iotests/306     |  546 +++++++
>>>  tests/qemu-iotests/306.out | 2846 ++++++++++++++++++++++++++++++++++++
>>>  tests/qemu-iotests/group   |    1 +
>>>  3 files changed, 3393 insertions(+)
>>>  create mode 100755 tests/qemu-iotests/306
>>>  create mode 100644 tests/qemu-iotests/306.out
>>>
>>> diff --git a/tests/qemu-iotests/306 b/tests/qemu-iotests/306
>>> new file mode 100755
>>> index 0000000000..1bb8bd4138
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/306
>>
>> [...]
>>
>>> +def test_bitmap_sync(bsync_mode, msync_mode=3D'bitmap', failure=3DNone=
):
>>> +    """
>>> +    Test bitmap mirror routines.
>>> +
>>> +    :param bsync_mode: Is the Bitmap Sync mode, and can be any of:
>>> +        - on-success: This is the "incremental" style mode. Bitmaps ar=
e
>>> +                      synchronized to what was copied out only on succ=
ess.
>>> +                      (Partial images must be discarded.)
>>> +        - never:      This is the "differential" style mode.
>>> +                      Bitmaps are never synchronized.
>>> +        - always:     This is a "best effort" style mode.
>>> +                      Bitmaps are always synchronized, regardless of f=
ailure.
>>> +                      (Partial images must be kept.)
>>> +
>>> +    :param msync_mode: The mirror sync mode to use for the first mirro=
r.
>>> +                       Can be any one of:
>>> +        - bitmap: mirrors based on bitmap manifest.
>>> +        - full:   Full mirrors.
>>> +        - top:    Full mirrors of the top layer only.
>>> +
>>> +    :param failure: Is the (optional) failure mode, and can be any of:
>>> +        - None:         No failure. Test the normative path. Default.
>>> +        - simulated:    Cancel the job right before it completes.
>>> +                        This also tests writes "during" the job.
>>> +        - intermediate: This tests a job that fails mid-process and pr=
oduces
>>> +                        an incomplete mirror. Testing limitations prev=
ent
>>> +                        testing competing writes.
>>> +    """
>>> +    with iotests.FilePath('img', 'bsync1', 'bsync2', 'bsync3',
>>> +                            'fmirror0', 'fmirror1', 'fmirror2', 'fmirr=
or3') as \
>>
>> The indentation is off now.
>>
>>> +                            (img_path, bsync1, bsync2, bsync3,
>>> +                             fmirror0, fmirror1, fmirror2, fmirror3), =
\
>>> +         iotests.VM() as vm:
>> Hm.  On tmpfs, this test fails for me:
>>
>> ($ TEST_DIR=3D/tmp/iotest ./check -qcow2 306)
>>
>> @@ -170,7 +170,7 @@
>>      "drive0": [
>>        {
>>          "busy": false,
>> -        "count": 262144,
>> +        "count": 458752,
>>          "granularity": 65536,
>>          "persistent": false,
>>          "recording": true,
>> @@ -464,7 +464,7 @@
>>      "drive0": [
>>        {
>>          "busy": false,
>> -        "count": 262144,
>> +        "count": 458752,
>>          "granularity": 65536,
>>          "persistent": false,
>>          "recording": true,
>> @@ -760,7 +760,7 @@
>>      "drive0": [
>>        {
>>          "busy": false,
>> -        "count": 262144,
>> +        "count": 393216,
>>          "granularity": 65536,
>>          "persistent": false,
>>          "recording": true,
>> @@ -1056,7 +1056,7 @@
>>      "drive0": [
>>        {
>>          "busy": false,
>> -        "count": 262144,
>> +        "count": 458752,
>>          "granularity": 65536,
>>          "persistent": false,
>>          "recording": true,
>> @@ -1350,7 +1350,7 @@
>>      "drive0": [
>>        {
>>          "busy": false,
>> -        "count": 262144,
>> +        "count": 458752,
>>          "granularity": 65536,
>>          "persistent": false,
>>          "recording": true,
>> @@ -2236,7 +2236,7 @@
>>      "drive0": [
>>        {
>>          "busy": false,
>> -        "count": 262144,
>> +        "count": 458752,
>>          "granularity": 65536,
>>          "persistent": false,
>>          "recording": true,
>>
>> Can you see the same?
>=20
> yes, but also only on tmpfs. ext4, xfs, ZFS all work fine.. the numbers=
=20
> for tmpfs vary between runs, each wrong count is sometimes 393216 (256k=
=20
> expected + 128k extra), sometimes 458752 (+192k). it's always the dirty=
=20
> bitmap used by the mirror job which is 'wrong', not the passed-in sync=20
> bitmap which verifies correctly. the final mirror results also seem=20
> correct.
>=20
> for the first diff hunk (bitmap + never + simulated), we did
>=20
> - reference mirror #0
> - add sync bitmap 'bitmap0'
> - do writes to dirty 6 sectors (393216)
> - reference mirror #1
> - test mirror #1
> - bitmap0 still has count 393216
> - reference mirror #2
> - test mirror #2
> -- while that is not yet completed, do 4 more writes
> -- bitmap0 now has count 393216 + 262144 655360
> -- dirty bitmap 'should have' count 262144, but has 458752 or 393216
>=20
> this is not what actually interests us at this point: how far the mirror=
=20
> has progressed does not matter, we just want to see that the writes we=20
> did while it was ongoing have been reflected in the sync bitmap.

I see.  The active bitmap the backup job adds isn=E2=80=99t cleared when
progress is made (it=E2=80=99s only used to capture dirtying writes while t=
he
job runs, so the initial bitmap stays constant), in contrast to the one
that mirror adds.  Backup doesn=E2=80=99t clear any bitmap, because it does=
n=E2=80=99t
need to =E2=80=93 a single iteration is sufficient to catch everything that=
 was
dirty at the beginning of the job.

So, yes, we should hide dirty_bitmap, as it can be in an arbitrary state
while the mirror job is running, and it doesn=E2=80=99t give us useful info=
rmation.

> unless there is some hunch that this difference in mirroring 'speed'=20
> between the file systems is something that we need to take a look at,=20
> I'd say we just dump bitmap0 after the writes have been performed,=20
> instead of all bitmaps (in line 230f).

Looks like there is never any other bitmap bit bitmap0 and the mirror=E2=80=
=99s
dirty_bitmap, so this sounds like a good idea.

Max


--Yx8YgQfaRJjzzWV9Fgb1dcESM3n7FbvNA--

--GvqSIWW58nH45798bEILAsteJ2znMxVB3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+FulMACgkQ9AfbAGHV
z0CeKQf/RmEMhVZ51P78XQDFzf4miM05iCCI6f9mz6L3Rj9xamGgvvmJ++Q7Jctl
emlPkC0gnuYCjWvFbnSaC3mlGr8zcVCjoPmlcbQXs8qGAqWOUEDHIys3lmh7Ol5U
dwjn/pknyWAmf1Ph3FoRpsLBOqTtb8GwWiM4uJog6EUG6Cm6KBuRMxSrzju2CGQs
aIF+Enk0O5FZq+h5UesSD0SAMk/kInK1C/OSsvU5gayLGryriGAnqvETEbNQkXKf
DxbMmIN3B0zUcAXUZtxqWLK3sULGwWDskabWHVHaW29OAK/9Y4naNX9izLqnwpIr
JkkDwdIx3YESXkiBn52jGP/YKofGRQ==
=S3n+
-----END PGP SIGNATURE-----

--GvqSIWW58nH45798bEILAsteJ2znMxVB3--


