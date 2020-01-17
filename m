Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0945C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8ABA20728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHYVppGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8ABA20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRpo-00084t-8r
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isRlE-00039M-Dg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isRlA-0000Al-Lx
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:34:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51558
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isRl3-00004x-Dh
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579268032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y3SzMAzbADTBE0GYRSa4giIWDbHlwzbWRE4u8/8geyI=;
 b=HHYVppGejpLCMlVJqWmEOWEXxOHiNM5aL/XSbGlvJMeXiqczlvMq6YY5/EJhuUdb+7XeLh
 Use36/JV+sbdyJWP6KnJOK6fmxzJbzPboiaFrXirEGpO8ikXR1gWmXbnVfRjU7Rt45gcsZ
 Gjia7pPN4GrClzb1VThmok37DgwlrsY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-zo5eHLedNqGh5dXf5HbR_g-1; Fri, 17 Jan 2020 08:33:49 -0500
Received: by mail-wr1-f69.google.com with SMTP id u18so10483170wrn.11
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:33:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9G7/8bbJigEpulwrvNvAKN7AbKqJ5FQn9jZVZd9SbGw=;
 b=FlTnvDCpESl59P2pDk4kW9mIxMfeVgtOdkFePuXpj+7Pw275ZgSSo6nRSRApKh7KdV
 N2uQJxqkLJZOXg/xd2MOo/BK5z2nwX+oPXG6VK/l/qPoMVEnH9Xq/WkzrrMf6ZAEIHbf
 II36NAzi34B2YqV0DdB1BUSGQfNSHapoP1s1k4n4kTMiM9I6OUqlH+kZZ6NKUK0eIUS2
 HFsPhMynboi7JZdpZMJKatNBd6yC4SV3IVW4OMO2s+RlGVoNa15IKvBqi/qd/9hRje1n
 YjpyUr68KwqKT5gavn1CAzKezXm5e60ltxH08zSFmsySrgxnvK/h7ZQgSOkkwuT4Gn/F
 6fMg==
X-Gm-Message-State: APjAAAWE9oRNhol1lUFgPGTNlwEvhBOxwU9zlt7uwT5Xq6TsD6mU+CGm
 i58oK2aOoNXI/pfC+HqA+7z+XTCDek3YnxY2yaBFILzrFW67xODSQh6pmShbU3xl7n1EKtoOjh0
 vdHOCupg3h8s6fY4=
X-Received: by 2002:adf:a41c:: with SMTP id d28mr3218166wra.410.1579268028454; 
 Fri, 17 Jan 2020 05:33:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxAsvB+2bw8nN3Q9v9L3aSI+FX+OeRzWax7umEeJl10atz7ihIoPG21KRiF5oKhr6OxQmGfBg==
X-Received: by 2002:adf:a41c:: with SMTP id d28mr3218152wra.410.1579268028202; 
 Fri, 17 Jan 2020 05:33:48 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id t5sm33402157wrr.35.2020.01.17.05.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 05:33:47 -0800 (PST)
Subject: Re: [PATCH 104/104] virtiofsd: Convert lo_destroy to take the
 lo->mutex lock itself
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-105-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fc2bbbfa-4a10-f01f-c681-5e1fbe6c249d@redhat.com>
Date: Fri, 17 Jan 2020 14:33:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-105-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: zo5eHLedNqGh5dXf5HbR_g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 5:39 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> lo_destroy was relying on some implicit knowledge of the locking;
> we can avoid this if we create an unref_inode that doesn't take
> the lock and then grab it for the whole of the lo_destroy.
>=20
> Suggested-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   tools/virtiofsd/passthrough_ll.c | 31 +++++++++++++++++--------------
>   1 file changed, 17 insertions(+), 14 deletions(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 38f4948e61..c37f57157e 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -1328,14 +1328,13 @@ static void lo_unlink(fuse_req_t req, fuse_ino_t =
parent, const char *name)
>       lo_inode_put(lo, &inode);
>   }
>  =20
> -static void unref_inode_lolocked(struct lo_data *lo, struct lo_inode *in=
ode,
> -                                 uint64_t n)
> +/* To be called with lo->mutex held */
> +static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint=
64_t n)
>   {
>       if (!inode) {
>           return;
>       }
>  =20
> -    pthread_mutex_lock(&lo->mutex);
>       assert(inode->nlookup >=3D n);
>       inode->nlookup -=3D n;
>       if (!inode->nlookup) {
> @@ -1346,15 +1345,24 @@ static void unref_inode_lolocked(struct lo_data *=
lo, struct lo_inode *inode,
>           }
>           g_hash_table_destroy(inode->posix_locks);
>           pthread_mutex_destroy(&inode->plock_mutex);
> -        pthread_mutex_unlock(&lo->mutex);
>  =20
>           /* Drop our refcount from lo_do_lookup() */
>           lo_inode_put(lo, &inode);
> -    } else {
> -        pthread_mutex_unlock(&lo->mutex);
>       }
>   }
>  =20
> +static void unref_inode_lolocked(struct lo_data *lo, struct lo_inode *in=
ode,
> +                                 uint64_t n)
> +{
> +    if (!inode) {
> +        return;
> +    }
> +
> +    pthread_mutex_lock(&lo->mutex);
> +    unref_inode(lo, inode, n);
> +    pthread_mutex_unlock(&lo->mutex);
> +}
> +
>   static void lo_forget_one(fuse_req_t req, fuse_ino_t ino, uint64_t nloo=
kup)
>   {
>       struct lo_data *lo =3D lo_data(req);
> @@ -2441,13 +2449,7 @@ static void lo_destroy(void *userdata)
>   {
>       struct lo_data *lo =3D (struct lo_data *)userdata;
>  =20
> -    /*
> -     * Normally lo->mutex must be taken when traversing lo->inodes but
> -     * lo_destroy() is a serialized request so no races are possible her=
e.
> -     *
> -     * In addition, we cannot acquire lo->mutex since unref_inode() take=
s it
> -     * too and this would result in a recursive lock.
> -     */
> +    pthread_mutex_lock(&lo->mutex);
>       while (true) {
>           GHashTableIter iter;
>           gpointer key, value;
> @@ -2458,8 +2460,9 @@ static void lo_destroy(void *userdata)
>           }
>  =20
>           struct lo_inode *inode =3D value;
> -        unref_inode_lolocked(lo, inode, inode->nlookup);
> +        unref_inode(lo, inode, inode->nlookup);
>       }
> +    pthread_mutex_unlock(&lo->mutex);
>   }
>  =20
>   static struct fuse_lowlevel_ops lo_oper =3D {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


