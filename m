Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F373C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544D32084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544D32084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35943 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvYu-000502-C6
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:45:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEvMK-00013U-Ka
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEvMI-00086l-N0
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:32:44 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hEvMI-00086M-Br
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:32:42 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MKKpV-1hainJ1s6B-00LjNw; Fri, 12 Apr 2019 14:32:30 +0200
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org
References: <20190412121626.19829-1-berrange@redhat.com>
	<20190412121626.19829-3-berrange@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9a7df5b1-72e1-ac35-7f06-a0652db163b1@vivier.eu>
Date: Fri, 12 Apr 2019 14:32:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190412121626.19829-3-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jhLrY2m+K5WwF1YLz81wMq0GLhFzbO+JmMu8sd5asMljqTfKofm
	5PBay0k26ynde0saGZK6eTydcQFtp4+XQwAoo4/mC4HlCr46fP1G2BCblT2Ak4fh9ppu8Xw
	WoyRRTzzVpd0MWrh7m2pDDbZjgTapCdhKumErW9TYZGv73OowGdVT42BjpnoSfd+C8ruQuR
	A8fhlWofb0c0dgqzwdbdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fJOPBZ/MvWU=:Al0IzHd9Q8HQqNH8LstKHY
	AhcOZ1COp8FsUCSn8nlst28kPE4RU85kYZsXFtGA3aFy7oTMW38qc5HjN+ZtLovPO9jLyT4xS
	vlVoj3kJxxAiV78b1o4kyV5dnVnzYDauIR2NEq0xq5LMkXcg7l2adE9c0S286tBLS7pSo8o67
	DoF+UfyizFu82RC54tsIxV8LyywFDbpmcWq7nPJTG/z4elrbsu3ELtI03O1hldtf6cQttfAlr
	cZV6bENSYiKkoQn25PuYNZlf5El3X2JugILgnsLXPqLRftEgYbWMby8d413b4BkQDXwfbLQec
	TVjSgsPgP0iJ/Vx02vvm8AgLAdRzHucJ+L0x+X4PP9XELxfCg9BkuNKP72fkE7nzRhNpHcTrl
	OezHAMM32aFof65S4rmuXsGSjjrJwwNdsRZ2fwwN1DUpZK79mOVxTMP/UZ5paEMb0Mdocdozn
	tGnkNplbsY52qVM9uXuSkbx1R5kSqmbGwqeLlC7rpNEvk0EtS0t0GqBO87Y2HVkZfrhBvBVRi
	KVyg50MXerAilSrkUfpKHnfedmDC967IBLlBE0yaRCZgEZIVj7zlfpiMlM7+HaV1WM1M1WEoR
	sshYyq5XIQgqgMCOBT3PDOCBhhx8NHIEW2f+PjU8nLA/jYY8jztaVcQXJ4tWpG7BWxufd9XBb
	AtPWmqex8CdyU6d5fdcsNAInRigQ3tsqBgdJ9hV2YOOTkJO/bwBh/+hCmpLBT+NXMWN3oj+Ig
	6OG/D6gS27gF3xU8DD2vE5Ht+bsUBf55ec37VC4nDxOp2Mfjgv3V30qSCo4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: Re: [Qemu-devel] [PATCH v2 2/5] linux-user: avoid string truncation
 warnings in elf field copying
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412123228.7w897HnG5kAo8UH592sMXRdWjGzvF-v17yBqzw0j3TU@z>

On 12/04/2019 14:16, Daniel P. Berrangé wrote:
> In file included from /usr/include/string.h:494,
>                  from include/qemu/osdep.h:101,
>                  from linux-user/elfload.c:2:
> In function ‘strncpy’,
>     inlined from ‘fill_psinfo’ at linux-user/elfload.c:3208:12,
>     inlined from ‘fill_note_info’ at linux-user/elfload.c:3390:5,
>     inlined from ‘elf_core_dump’ at linux-user/elfload.c:3539:9:
> /usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ specified bound 16 equals destination size [-Wstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> We don't require the field to be NUL terminated, so can just
> copy the lower of the string length and the target field size
> using memcpy.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  linux-user/elfload.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a26021f8..caa060f7b7 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3180,6 +3180,7 @@ static int fill_psinfo(struct target_elf_prpsinfo *psinfo, const TaskState *ts)
>  {
>      char *base_filename;
>      unsigned int i, len;
> +    size_t pathlen;
>  
>      (void) memset(psinfo, 0, sizeof (*psinfo));
>  
> @@ -3201,12 +3202,9 @@ static int fill_psinfo(struct target_elf_prpsinfo *psinfo, const TaskState *ts)
>      psinfo->pr_gid = getgid();
>  
>      base_filename = g_path_get_basename(ts->bprm->filename);
> -    /*
> -     * Using strncpy here is fine: at max-length,
> -     * this field is not NUL-terminated.
> -     */

Keep and update the comment, it explains why we don't need to add the
NUL at the end when MIN() is sizeof(psinfo->pr_fname).

> -    (void) strncpy(psinfo->pr_fname, base_filename,
> -                   sizeof(psinfo->pr_fname));
> +    pathlen = strlen(base_filename) + 1;
> +    pathlen = MIN(pathlen, sizeof(psinfo->pr_fname));
> +    memcpy(psinfo->pr_fname, base_filename, pathlen);
>  
>      g_free(base_filename);
>      bswap_psinfo(psinfo);
> 

Thanks,
Laurent


