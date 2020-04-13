Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0169C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 17:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BE420735
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 17:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q6vVi0MD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BE420735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO2ij-0001EM-S5
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 13:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jO2hs-0000iI-IU
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 13:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jO2hr-0000lt-Fa
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 13:17:12 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jO2hq-0000Xt-TM; Mon, 13 Apr 2020 13:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=zy4Qk2PrHlQZCSGSbGjPaNsMasjSKFuHJ+FQTllXymg=; 
 b=Q6vVi0MD3B1tk34Fj0RkH3vgwDcf2N5aCEDS01DSqdgOfuM87VVmtQYKOZJODaN4u7qgDAR/G1Z4Wp4E6CtRBvsAteG9zAwxre90q1jQF4AsXgZJq+kbXPR99m397SjqEWE7XXicmfayvC5hgkCk5oFTa5XuFGRzoakLD/vHloNlwCrrjiJr/9HISNUwcc/YecLPYHgVurofmtQY9Oakw5kp5kjEO9MwVstMzv/HAmmG8qDqFSOeWSAJGMwAuDDhLekjhfdgTVknstnMb+uHGh3WMRN3QLkMJT3EtRUMg9ZkV25TxW7VB6Q83t1RT5xmOPQdPqDYsh2z7b/ED0EdaA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jO2hU-0001G6-NK; Mon, 13 Apr 2020 19:16:48 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jO2hU-0003zg-Dh; Mon, 13 Apr 2020 19:16:48 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 30/30] iotests: Add tests for qcow2 images with
 extended L2 entries
In-Reply-To: <3684cc01-3082-c52a-bd58-49300244a6eb@redhat.com>
References: <cover.1584468723.git.berto@igalia.com>
 <420b76fbe25d5e2eeda53490a1c646935dab61c4.1584468724.git.berto@igalia.com>
 <3684cc01-3082-c52a-bd58-49300244a6eb@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 13 Apr 2020 19:16:48 +0200
Message-ID: <w51tv1ni9vj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 09 Apr 2020 02:22:37 PM CEST, Max Reitz wrote:
>> +    ### Write subcluster #31-#34 (cluster overlap) ###
>
> #31-#34, I think.

That's what I wrote :-?

>> +    ### Partially zeroize an unallocated cluster (#3)
>> +    if [ "$use_backing_file" =3D "yes" ]; then
>> +        alloc=3D"`seq 0 15`"; zero=3D""
>
> Isn=E2=80=99t this a TODO?  (I.e., ideally we=E2=80=99d want the first 16=
 subclusters
> to be zero, and the last 16 subclusters to be unallocated, right?)
>
> (I=E2=80=99m asking because you did raise a TODO for the =E2=80=9CZero su=
bcluster #1=E2=80=9D
> test)

Maybe, but I just implemented zeroize at the subcluster level :-) Wait
for the next version of the series.

>> +    echo
>> +    echo "### Compressed cluster with subcluster bitmap !=3D 0 - $corru=
ption_test_cmd test ###"
>> +    echo
>> +    # We actually don't consider this a corrupted image.
>> +    # The bitmap in compressed clusters is unused so QEMU should just i=
gnore it.
>> +    _make_test_img 1M
>> +    $QEMU_IO -c 'write -q -P 11 -c 0 64k' "$TEST_IMG"
>> +    poke_file "$TEST_IMG" $(($l2_offset+11)) "\x01\x01"
>> +    alloc=3D"24"; zero=3D"0"
>> +    _verify_l2_bitmap 0 "$alloc" "$zero"
>> +    $QEMU_IO -c "$corruption_test_cmd -P 11 0 64k" "$TEST_IMG" | _filte=
r_qemu_io
>
> It might be interesting to see the bitmap after the write, i.e., that
> it=E2=80=99s just been ignored.

Yeah, why not.

>> +echo "# 16K clusters, 64GB, extended_l2=3Doff" # This needs one L1 table
>
> You mean one full L1 table cluster?
>
>> +$QEMU_IMG measure --size 64G -O qcow2 -o cluster_size=3D16k,extended_l2=
=3Doff
>> +echo "# 16K clusters, 64GB, extended_l2=3Don"  # This needs two L2 tabl=
es
>
> And two full L1 table clusters?

You're right, I'll correct that.

Berto

