Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F262C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3E12078E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gykolS/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3E12078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRna-0006Bi-7Q
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 08:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDRn3-0005kf-Ew
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDRn1-0002XU-En
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599049378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nZBI34/55AeILFoGtx5boC2D/qhNt1yo6cbhqD/y6LY=;
 b=gykolS/MZb8Qh60FiGb9y5VSo2Spp9wSk8cseMJSDA5tUoJHY+Sj/ejL7g3eUAVCLNS13+
 89ch8ACc+WNCQJtLL7uNQZ/xEA+JcApFXZSpbAmy4xVQHlgAw52QexYFL4KvtmXvluo1gD
 VOCnqVwizp4h/gbwyo4eeWCqKq958Vk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-kpT-dmhYO1-rDRhX8Zsczg-1; Wed, 02 Sep 2020 08:22:53 -0400
X-MC-Unique: kpT-dmhYO1-rDRhX8Zsczg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 908A210ABDB1;
 Wed,  2 Sep 2020 12:22:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-169.ams2.redhat.com
 [10.36.114.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A93927EEA7;
 Wed,  2 Sep 2020 12:22:45 +0000 (UTC)
Subject: Re: [PATCH v3 1/7] block/quorum.c: stable children names
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1596536719.git.lukasstraub2@web.de>
 <5d5f930424c1c770754041aa8ad6421dc4e2b58e.1596536719.git.lukasstraub2@web.de>
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
Message-ID: <250d7ece-9137-8993-fffb-8d5ab205be5b@redhat.com>
Date: Wed, 2 Sep 2020 14:22:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5d5f930424c1c770754041aa8ad6421dc4e2b58e.1596536719.git.lukasstraub2@web.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04.08.20 12:46, Lukas Straub wrote:
> If we remove the child with the highest index from the quorum,
> decrement s->next_child_index. This way we get stable children
> names as long as we only remove the last child.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> Fixes: https://bugs.launchpad.net/bugs/1881231
> Reviewed-by: Zhang Chen <chen.zhang@intel.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/quorum.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/block/quorum.c b/block/quorum.c
> index 6df9449fc2..e846a7e892 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -29,6 +29,8 @@
> 
>  #define HASH_LENGTH 32
> 
> +#define INDEXSTR_LEN 32
> +

I don’t like this too much.  There is no real concept such as an index
string, and it doesn’t have a fixed length.  It just so happens that
there are a couple of places where we need some buffer to snprintf()
into, and all those places happen to use 32 because that’s definitely
sufficient for “children.%u”.  (Technically, it should not be fixed to
32, but “sizeof("children.") + ceil(log_10(INT_MAX))”.)

Whenever we then use such a buffer, we shouldn’t use the same hard-coded
magic number or constant, but instead just refer to the size of the buffer:

>  #define QUORUM_OPT_VOTE_THRESHOLD "vote-threshold"
>  #define QUORUM_OPT_BLKVERIFY      "blkverify"
>  #define QUORUM_OPT_REWRITE        "rewrite-corrupted"
> @@ -970,9 +972,9 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
>      opened = g_new0(bool, s->num_children);
> 
>      for (i = 0; i < s->num_children; i++) {
> -        char indexstr[32];
> -        ret = snprintf(indexstr, 32, "children.%d", i);
> -        assert(ret < 32);
> +        char indexstr[INDEXSTR_LEN];
> +        ret = snprintf(indexstr, INDEXSTR_LEN, "children.%d", i);
> +        assert(ret < INDEXSTR_LEN);

So in lines 2 and 3 here we should just use sizeof(indexstr).

> 
>          s->children[i] = bdrv_open_child(NULL, options, indexstr, bs,
>                                           &child_of_bds, BDRV_CHILD_DATA, false,
> @@ -1024,7 +1026,7 @@ static void quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs,
>  {
>      BDRVQuorumState *s = bs->opaque;
>      BdrvChild *child;
> -    char indexstr[32];
> +    char indexstr[INDEXSTR_LEN];
>      int ret;
> 
>      if (s->is_blkverify) {
> @@ -1039,8 +1041,8 @@ static void quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs,
>          return;
>      }
> 
> -    ret = snprintf(indexstr, 32, "children.%u", s->next_child_index);
> -    if (ret < 0 || ret >= 32) {
> +    ret = snprintf(indexstr, INDEXSTR_LEN, "children.%u", s->next_child_index);
> +    if (ret < 0 || ret >= INDEXSTR_LEN) {

Same here.

>          error_setg(errp, "cannot generate child name");
>          return;
>      }
> @@ -1068,6 +1070,7 @@ static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
>                               Error **errp)
>  {
>      BDRVQuorumState *s = bs->opaque;
> +    char indexstr[INDEXSTR_LEN];
>      int i;
> 
>      for (i = 0; i < s->num_children; i++) {
> @@ -1089,6 +1092,11 @@ static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
>      /* We know now that num_children > threshold, so blkverify must be false */
>      assert(!s->is_blkverify);
> 
> +    snprintf(indexstr, INDEXSTR_LEN, "children.%u", s->next_child_index - 1);
> +    if (!strncmp(child->name, indexstr, INDEXSTR_LEN)) {

And here.

I also wonder if there should be an assertion/check checking snprintf’s
return value (as is done in the other places), but then again, it
doesn’t really matter.  But it would make the length limitation of
strncmp() superfluous and a plain strcmp() would suffice.

(I don’t like strncmp() very much here, because we have a problem if
indexstr’s length doesn’t suffice to hold children.%u, and we then
compare only the first INDEXSTR_LEN bytes with child->name.  That would
be a bug.  Just a different bug than an out-of-bounds read.)

> +        s->next_child_index--;
> +    }
> +
>      bdrv_drained_begin(bs);
> 
>      /* We can safely remove this child now */

Now, all in all, it doesn’t really matter of course.  This patch works
and introducing INDEXSTR_LEN isn’t worse than just using 32 as a magic
number.  So I’ll take the patch as-is for now – if you think that using
sizeof(indexstr) and/or replacing the strncmp() by assert()+strcmp()
would be so much better to justify a v4 (of this patch) or a follow-up
patch, then, well, that could still be done. O:)

tl;dr: Thanks, I’ve applied this patch to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


