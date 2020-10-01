Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F625C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 793712054F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLXzNzXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793712054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2bR-0006Mz-Ep
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kO2QP-00036K-83
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kO2QN-00055I-0Y
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601573481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4U8U4/hvtLzLzVU5QfqRX5hqIJB7EcGBHRieizUMcqI=;
 b=KLXzNzXA39vH7o836D2AvHPARisY3LPLJ231fbmo1Qf6VuEg0LN82nrwW9P4oJfop4z6Yl
 2yK290Ktn9rIjHJ2WBVtXolbGM9KvuLXDYhfy3VEYXUQmQ7rG+rthiZfovaW7C7xQ2l4Z+
 ga6OuSuycrdPDPHkuFTbWK0WgsWFG44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-EMkMKcKMMCaNLPxgOZfykA-1; Thu, 01 Oct 2020 13:31:19 -0400
X-MC-Unique: EMkMKcKMMCaNLPxgOZfykA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C25821891E83;
 Thu,  1 Oct 2020 17:31:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-181.ams2.redhat.com
 [10.36.113.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19E495D9D3;
 Thu,  1 Oct 2020 17:31:16 +0000 (UTC)
Subject: Re: [PATCH qemu 4/4] iotests: add test for bitmap mirror
To: =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>,
 qemu-devel@nongnu.org
References: <20200922091418.53562-1-f.gruenbichler@proxmox.com>
 <20200922091418.53562-5-f.gruenbichler@proxmox.com>
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
Message-ID: <5336db8d-b54a-0881-5675-ca23f9645e65@redhat.com>
Date: Thu, 1 Oct 2020 19:31:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922091418.53562-5-f.gruenbichler@proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Py0oRnMf4lIeVf9GJxzWIvoocAM1qNkgf"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
--Py0oRnMf4lIeVf9GJxzWIvoocAM1qNkgf
Content-Type: multipart/mixed; boundary="BEqjfZStfHpBPSDCwnWa4tQ40NQV2Xcj4"

--BEqjfZStfHpBPSDCwnWa4tQ40NQV2Xcj4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.09.20 11:14, Fabian Gr=C3=BCnbichler wrote:
> heavily based on/practically forked off iotest 257 for bitmap backups,
> but:
>=20
> - no writes to filter node 'mirror-top' between completion and
> finalization, as those seem to deadlock?
> - no inclusion of not-yet-available full/top sync modes in combination
> with bitmaps
> - extra set of reference/test mirrors to verify that writes in parallel
> with active mirror work
>=20
> intentionally keeping copyright and ownership of original test case to
> honor provenance.
>=20
> Signed-off-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>
> ---
>  tests/qemu-iotests/306     |  546 +++++++
>  tests/qemu-iotests/306.out | 2846 ++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group   |    1 +
>  3 files changed, 3393 insertions(+)
>  create mode 100755 tests/qemu-iotests/306
>  create mode 100644 tests/qemu-iotests/306.out
>=20
> diff --git a/tests/qemu-iotests/306 b/tests/qemu-iotests/306
> new file mode 100755
> index 0000000000..1bb8bd4138
> --- /dev/null
> +++ b/tests/qemu-iotests/306

[...]

> +def test_bitmap_sync(bsync_mode, msync_mode=3D'bitmap', failure=3DNone):
> +    """
> +    Test bitmap mirror routines.
> +
> +    :param bsync_mode: Is the Bitmap Sync mode, and can be any of:
> +        - on-success: This is the "incremental" style mode. Bitmaps are
> +                      synchronized to what was copied out only on succes=
s.
> +                      (Partial images must be discarded.)
> +        - never:      This is the "differential" style mode.
> +                      Bitmaps are never synchronized.
> +        - always:     This is a "best effort" style mode.
> +                      Bitmaps are always synchronized, regardless of fai=
lure.
> +                      (Partial images must be kept.)
> +
> +    :param msync_mode: The mirror sync mode to use for the first mirror.
> +                       Can be any one of:
> +        - bitmap: mirrors based on bitmap manifest.
> +        - full:   Full mirrors.
> +        - top:    Full mirrors of the top layer only.
> +
> +    :param failure: Is the (optional) failure mode, and can be any of:
> +        - None:         No failure. Test the normative path. Default.
> +        - simulated:    Cancel the job right before it completes.
> +                        This also tests writes "during" the job.
> +        - intermediate: This tests a job that fails mid-process and prod=
uces
> +                        an incomplete mirror. Testing limitations preven=
t
> +                        testing competing writes.
> +    """
> +    with iotests.FilePath('img', 'bsync1', 'bsync2', 'bsync3',
> +                            'fmirror0', 'fmirror1', 'fmirror2', 'fmirror=
3') as \

The indentation is off now.

> +                            (img_path, bsync1, bsync2, bsync3,
> +                             fmirror0, fmirror1, fmirror2, fmirror3), \
> +         iotests.VM() as vm:
Hm.  On tmpfs, this test fails for me:

($ TEST_DIR=3D/tmp/iotest ./check -qcow2 306)

@@ -170,7 +170,7 @@
     "drive0": [
       {
         "busy": false,
-        "count": 262144,
+        "count": 458752,
         "granularity": 65536,
         "persistent": false,
         "recording": true,
@@ -464,7 +464,7 @@
     "drive0": [
       {
         "busy": false,
-        "count": 262144,
+        "count": 458752,
         "granularity": 65536,
         "persistent": false,
         "recording": true,
@@ -760,7 +760,7 @@
     "drive0": [
       {
         "busy": false,
-        "count": 262144,
+        "count": 393216,
         "granularity": 65536,
         "persistent": false,
         "recording": true,
@@ -1056,7 +1056,7 @@
     "drive0": [
       {
         "busy": false,
-        "count": 262144,
+        "count": 458752,
         "granularity": 65536,
         "persistent": false,
         "recording": true,
@@ -1350,7 +1350,7 @@
     "drive0": [
       {
         "busy": false,
-        "count": 262144,
+        "count": 458752,
         "granularity": 65536,
         "persistent": false,
         "recording": true,
@@ -2236,7 +2236,7 @@
     "drive0": [
       {
         "busy": false,
-        "count": 262144,
+        "count": 458752,
         "granularity": 65536,
         "persistent": false,
         "recording": true,

Can you see the same?

Max


--BEqjfZStfHpBPSDCwnWa4tQ40NQV2Xcj4--

--Py0oRnMf4lIeVf9GJxzWIvoocAM1qNkgf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl92EmMACgkQ9AfbAGHV
z0B7sAf8CIzGxUiudEcEmlJMZ+wvHAmraHMCMKbGYgW7FW0jkyjRdfl013b3KdPV
7kqHBKfunvMPBvfuT2pGsSzN4JpL8AlPhJH9SFUl0mSVgamwGdcqUuMTZnkflcwR
0NFSYybgbo/SiNXeayz2VNnHDS+yUMplEVDrbHFKC4/3WDzoudW7bNiA8CKjMLTf
JZrEFBaPZz53Rzn7ZOqY/xNEwAxavtVqiAKgAiF5q5qLtnQv96cmz8fYGGd6+7Wc
Nw4mOQiPMo7NFvQWO4h7rAeBEpTFCvBhge8KOne9BTVNYGpio8m+QRDbies7A39i
7rz2SlrBcRBU/xoBbV3BtkcIwcVqsw==
=UYaD
-----END PGP SIGNATURE-----

--Py0oRnMf4lIeVf9GJxzWIvoocAM1qNkgf--


