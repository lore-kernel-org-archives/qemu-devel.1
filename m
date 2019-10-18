Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDDFCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D412064A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D412064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVhj-0006iY-90
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iLVcP-0003ag-2g
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iLVcN-0005SB-GU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:00:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46299)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iLVcJ-0005MA-6D; Fri, 18 Oct 2019 13:00:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0639B308421A;
 Fri, 18 Oct 2019 17:00:42 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 515BF60600;
 Fri, 18 Oct 2019 17:00:38 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] iotests: Fix 173
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20191015193503.25591-1-eblake@redhat.com>
 <20191015193503.25591-2-eblake@redhat.com>
 <4aa107c6-db84-006c-962a-81c90933c3a4@redhat.com>
 <912732a3-40ab-af81-e3ff-e328da23c977@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e2388225-0522-e455-da03-3fbf55f4473e@redhat.com>
Date: Fri, 18 Oct 2019 12:00:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <912732a3-40ab-af81-e3ff-e328da23c977@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 18 Oct 2019 17:00:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 7:17 AM, Max Reitz wrote:

>>> Why haven't we noticed the failure? Because the test rarely gets run:
>>> './check -qcow2 173' is insufficient (that defaults to using file pro=
tocol)
>>> './check -nfs 173' is insufficient (that defaults to using raw format=
)
>>> so the test is only run with:
>>> ./check -qcow2 -nfs 173
>>>
>>> Note that we already have a number of other problems with -nfs:
>>> ./check -nfs (fails 18/30)
>>> ./check -qcow2 -nfs (fails 45/76 after this patch)
>>> and it's not on my priority list to fix those.  Rather, I found this
>>> because of my next patch's work on tests using _send_qemu_cmd.
>>>
>>> Fixes: 655ae6b
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>   tests/qemu-iotests/173     | 4 ++--
>>>   tests/qemu-iotests/173.out | 6 +++++-
>>>   2 files changed, 7 insertions(+), 3 deletions(-)
>>
>> On second thought, I wonder whether this test actually does anything
>> with NFS.  It doesn=E2=80=99t look like it to me.
>>
>> I wonder because for some reason I can=E2=80=99t get NFS to work with =
qemu at
>> all.  I don=E2=80=99t think the iotests are at fault why so many tests=
 fail,
>> actually.
>=20
> OK, I was just missing an =E2=80=9Cinsecure=E2=80=9D in my exports.  I =
hate debugging NFS.

Hmm, that probably explains some of my failures as well.  It is not=20
obvious what has to be done to a system prior to being able to even run=20
'./check -nfs'; and it would be nice if ./check could give better=20
heads-up warnings about an insufficient setup.

You may indeed have a point that the test may work with other non-local=20
setups.  But with this a quick hack:

diff --git i/tests/qemu-iotests/173 w/tests/qemu-iotests/173
index 29dcaa1960df..c01d0186c6ba 100755
--- i/tests/qemu-iotests/173
+++ w/tests/qemu-iotests/173
@@ -40,7 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
  . ./common.qemu

  _supported_fmt qcow2
-_supported_proto nfs
+_supported_proto nbd nfs

  size=3D100M

./check -qcow2 -nfs 173   # still passes
./check -qcow2 -nbd 173   # fails:

+{"error": {"class": "GenericError", "desc": "Failed to get "write" lock"=
}}
+Timeout waiting for return on handle 0

there may be more I can do to let this test work with nbd as well, but=20
for the sake of getting this email sent, that's as far as I've gotten=20
for now.

>=20
> Now I=E2=80=99m down to 16/76 for qcow2, and most of those look benign.=
  (As in,
> they simply don=E2=80=99t support nfs.)
>=20
> Max
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

