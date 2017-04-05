Received: from eggs.gnu.org ([2001:4830:134:3::10]:35626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvr3r-0002i3-Sx
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvr3n-00059d-Ma
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:57:46 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvr3n-00058y-IU
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:57:43 -0400
Received: by mail-qt0-x241.google.com with SMTP id r45so3062889qte.0
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 12:57:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-4-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <96d32e70-7668-1014-fe47-67c979940fa7@amsat.org>
Date: Wed, 5 Apr 2017 16:57:37 -0300
MIME-Version: 1.0
In-Reply-To: <20170405194741.18956-4-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 03/13] s390x: Drop useless casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, armbru@redhat.com, Richard Henderson <rth@twiddle.net>

On 04/05/2017 04:47 PM, Eric Blake wrote:
> An upcoming Coccinelle cleanup script wanted to reformat the casts
> present in this file - but on closer look, we don't need the casts
> at all because C automatically converts void* to any other pointer.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/s390x/cpu_models.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 1434d15..ce461cc 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -376,12 +376,12 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
>
>  static void qdict_add_disabled_feat(const char *name, void *opaque)
>  {
> -    qdict_put((QDict *) opaque, name, qbool_from_bool(false));
> +    qdict_put(opaque, name, qbool_from_bool(false));
>  }
>
>  static void qdict_add_enabled_feat(const char *name, void *opaque)
>  {
> -    qdict_put((QDict *) opaque, name, qbool_from_bool(true));
> +    qdict_put(opaque, name, qbool_from_bool(true));
>  }
>
>  /* convert S390CPUDef into a static CpuModelInfo */
>
