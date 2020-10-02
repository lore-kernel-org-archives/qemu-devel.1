Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A184C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17B8206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17B8206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOGUA-0003Rz-Pm
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 04:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1kOGSm-0002cv-Ky
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:30:48 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:9729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1kOGSk-0002Zz-Ha
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:30:48 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 678CC45B95;
 Fri,  2 Oct 2020 10:23:31 +0200 (CEST)
Date: Fri, 02 Oct 2020 10:23:24 +0200
From: Fabian =?iso-8859-1?q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [PATCH qemu 4/4] iotests: add test for bitmap mirror
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200922091418.53562-1-f.gruenbichler@proxmox.com>
 <20200922091418.53562-5-f.gruenbichler@proxmox.com>
 <5336db8d-b54a-0881-5675-ca23f9645e65@redhat.com>
In-Reply-To: <5336db8d-b54a-0881-5675-ca23f9645e65@redhat.com>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1601624180.56wvsjysei.astroid@nora.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=f.gruenbichler@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 04:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On October 1, 2020 7:31 pm, Max Reitz wrote:
> On 22.09.20 11:14, Fabian Gr=C3=BCnbichler wrote:
>> heavily based on/practically forked off iotest 257 for bitmap backups,
>> but:
>>=20
>> - no writes to filter node 'mirror-top' between completion and
>> finalization, as those seem to deadlock?
>> - no inclusion of not-yet-available full/top sync modes in combination
>> with bitmaps
>> - extra set of reference/test mirrors to verify that writes in parallel
>> with active mirror work
>>=20
>> intentionally keeping copyright and ownership of original test case to
>> honor provenance.
>>=20
>> Signed-off-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>
>> ---
>>  tests/qemu-iotests/306     |  546 +++++++
>>  tests/qemu-iotests/306.out | 2846 ++++++++++++++++++++++++++++++++++++
>>  tests/qemu-iotests/group   |    1 +
>>  3 files changed, 3393 insertions(+)
>>  create mode 100755 tests/qemu-iotests/306
>>  create mode 100644 tests/qemu-iotests/306.out
>>=20
>> diff --git a/tests/qemu-iotests/306 b/tests/qemu-iotests/306
>> new file mode 100755
>> index 0000000000..1bb8bd4138
>> --- /dev/null
>> +++ b/tests/qemu-iotests/306
>=20
> [...]
>=20
>> +def test_bitmap_sync(bsync_mode, msync_mode=3D'bitmap', failure=3DNone)=
:
>> +    """
>> +    Test bitmap mirror routines.
>> +
>> +    :param bsync_mode: Is the Bitmap Sync mode, and can be any of:
>> +        - on-success: This is the "incremental" style mode. Bitmaps are
>> +                      synchronized to what was copied out only on succe=
ss.
>> +                      (Partial images must be discarded.)
>> +        - never:      This is the "differential" style mode.
>> +                      Bitmaps are never synchronized.
>> +        - always:     This is a "best effort" style mode.
>> +                      Bitmaps are always synchronized, regardless of fa=
ilure.
>> +                      (Partial images must be kept.)
>> +
>> +    :param msync_mode: The mirror sync mode to use for the first mirror=
.
>> +                       Can be any one of:
>> +        - bitmap: mirrors based on bitmap manifest.
>> +        - full:   Full mirrors.
>> +        - top:    Full mirrors of the top layer only.
>> +
>> +    :param failure: Is the (optional) failure mode, and can be any of:
>> +        - None:         No failure. Test the normative path. Default.
>> +        - simulated:    Cancel the job right before it completes.
>> +                        This also tests writes "during" the job.
>> +        - intermediate: This tests a job that fails mid-process and pro=
duces
>> +                        an incomplete mirror. Testing limitations preve=
nt
>> +                        testing competing writes.
>> +    """
>> +    with iotests.FilePath('img', 'bsync1', 'bsync2', 'bsync3',
>> +                            'fmirror0', 'fmirror1', 'fmirror2', 'fmirro=
r3') as \
>=20
> The indentation is off now.
>=20
>> +                            (img_path, bsync1, bsync2, bsync3,
>> +                             fmirror0, fmirror1, fmirror2, fmirror3), \
>> +         iotests.VM() as vm:
> Hm.  On tmpfs, this test fails for me:
>=20
> ($ TEST_DIR=3D/tmp/iotest ./check -qcow2 306)
>=20
> @@ -170,7 +170,7 @@
>      "drive0": [
>        {
>          "busy": false,
> -        "count": 262144,
> +        "count": 458752,
>          "granularity": 65536,
>          "persistent": false,
>          "recording": true,
> @@ -464,7 +464,7 @@
>      "drive0": [
>        {
>          "busy": false,
> -        "count": 262144,
> +        "count": 458752,
>          "granularity": 65536,
>          "persistent": false,
>          "recording": true,
> @@ -760,7 +760,7 @@
>      "drive0": [
>        {
>          "busy": false,
> -        "count": 262144,
> +        "count": 393216,
>          "granularity": 65536,
>          "persistent": false,
>          "recording": true,
> @@ -1056,7 +1056,7 @@
>      "drive0": [
>        {
>          "busy": false,
> -        "count": 262144,
> +        "count": 458752,
>          "granularity": 65536,
>          "persistent": false,
>          "recording": true,
> @@ -1350,7 +1350,7 @@
>      "drive0": [
>        {
>          "busy": false,
> -        "count": 262144,
> +        "count": 458752,
>          "granularity": 65536,
>          "persistent": false,
>          "recording": true,
> @@ -2236,7 +2236,7 @@
>      "drive0": [
>        {
>          "busy": false,
> -        "count": 262144,
> +        "count": 458752,
>          "granularity": 65536,
>          "persistent": false,
>          "recording": true,
>=20
> Can you see the same?

yes, but also only on tmpfs. ext4, xfs, ZFS all work fine.. the numbers=20
for tmpfs vary between runs, each wrong count is sometimes 393216 (256k=20
expected + 128k extra), sometimes 458752 (+192k). it's always the dirty=20
bitmap used by the mirror job which is 'wrong', not the passed-in sync=20
bitmap which verifies correctly. the final mirror results also seem=20
correct.

for the first diff hunk (bitmap + never + simulated), we did

- reference mirror #0
- add sync bitmap 'bitmap0'
- do writes to dirty 6 sectors (393216)
- reference mirror #1
- test mirror #1
- bitmap0 still has count 393216
- reference mirror #2
- test mirror #2
-- while that is not yet completed, do 4 more writes
-- bitmap0 now has count 393216 + 262144 655360
-- dirty bitmap 'should have' count 262144, but has 458752 or 393216

this is not what actually interests us at this point: how far the mirror=20
has progressed does not matter, we just want to see that the writes we=20
did while it was ongoing have been reflected in the sync bitmap. so=20
unless there is some hunch that this difference in mirroring 'speed'=20
between the file systems is something that we need to take a look at,=20
I'd say we just dump bitmap0 after the writes have been performed,=20
instead of all bitmaps (in line 230f).
=


