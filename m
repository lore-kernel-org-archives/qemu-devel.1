Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C59C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 18:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D772173E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 18:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjuDsP6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D772173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmxI-0001Jp-Rt
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 14:24:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hSmwB-0000ii-I7
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hSmw9-0000im-S5
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:23:03 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:33152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1hSmw9-0000hv-1k
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:23:01 -0400
Received: by mail-qt1-x841.google.com with SMTP id m32so17496848qtf.0
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=wVmUifK244luM5YlAWDZA91iS0hO4NaIrogfaVIpols=;
	b=ZjuDsP6ggOMlOsukO6UvCUIAqRTUTrheDFbtLRdTM/EekEsSZkj+Z4DUFrUxXmLHHv
	GitqLrofrN2WBr2TKG5SJRavUVK/NWiCcK40vCNpS1hBRRDy4/uouR5WM2f2LljuGRFN
	mPA6tZTsCpsDxw89TE3QcC47O76lyjV/8e2QYlfBe4eg9TCunEZl3IKJ8GKOBlZO8ago
	33iQ8Ik9AEOZBJe4UEbyZKjTrgRlpGvxxKQ0soNggKEIVhlSLyjJ9k29SfyKMePX5qzb
	A+g+A6Wbr+j0Aq2XdEmnJbAIx3vJbD/Rmy2RwsCBXzOiQ/Agfa/xE8/Cm89p1sSiN09S
	DcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=wVmUifK244luM5YlAWDZA91iS0hO4NaIrogfaVIpols=;
	b=Y3TSef6lXtpaU0xxWlXXj30tx/BnfLw3EHrYOaAB5bNG4UtcfbCHNhdIMtdnio7ZX8
	NhpYrYckfY4KSeFLRtD5kvRjU6Ut9LnyIGEqgf4NXWlbvLxyUkpNM6Egvho8yxVArbOA
	WcbzsxHURfeb7FFyUEpsCqnIhADRvNTOeJq8f9ndEZJWPlQoW9DjLBSX8Xv5dJIO0nAN
	GTo7iC0q0Kzg7VBJ/OKFXUsabxguE02+BzKmI/lOdI95OS8WVGKUj3JDdFzg5J/3JOnF
	VnXB2OuLbVfrZUGitUp88YqDh6bZY8hZIOnuybMM82ypAJNQUspQu82LRTIhtWtmja30
	n6hw==
X-Gm-Message-State: APjAAAU9AJe0BoihfY0LZ3DxFNyxa7uksadA4lAVWHGmS2E6Kuwo3YAj
	vX4UmXW6TCcLewJKdbzO+Pw=
X-Google-Smtp-Source: APXvYqxNebuDtZKesdyaz2TmFjFazyZhd2bqWQaL/6O6kRXpFrFVS3rcDjm5uYgVF9rfpZjI88mUTg==
X-Received: by 2002:a0c:baa7:: with SMTP id x39mr16590083qvf.100.1558376577024;
	Mon, 20 May 2019 11:22:57 -0700 (PDT)
Received: from ?IPv6:2804:431:f701:9e22:ebb5:4019:e2bd:55e4?
	([2804:431:f701:9e22:ebb5:4019:e2bd:55e4])
	by smtp.gmail.com with ESMTPSA id
	v3sm13634943qtc.97.2019.05.20.11.22.55
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 11:22:56 -0700 (PDT)
To: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <20190519084815.7410-1-ppandit@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <d3626247-a6b1-afd3-4f48-8fbbe3ad5dbb@gmail.com>
Date: Mon, 20 May 2019 15:22:53 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190519084815.7410-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: Re: [Qemu-devel] [PATCH v2] qga: check length of command-line &
 environment variables
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Niu Guoxiang <niuguoxiang@huawei.com>,
	Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/19/19 5:48 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Qemu guest agent while executing user commands does not seem to
> check length of argument list and/or environment variables passed.
> It may lead to integer overflow or infinite loop issues. Add check
> to avoid it.
>
> Reported-by: Niu Guoxiang <niuguoxiang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   qga/commands-posix.c   | 18 ++++++++++++++++++
>   qga/commands-win32.c   | 13 +++++++++++++
>   qga/commands.c         |  8 ++++++--
>   qga/guest-agent-core.h |  2 ++
>   4 files changed, 39 insertions(+), 2 deletions(-)
>
> Update v2: add helper function ga_get_arg_max()
>    -> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06360.html
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 7ee6a33cce..e0455722e0 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -60,6 +60,24 @@ extern char **environ;
>   #endif
>   #endif
>   
> +size_t ga_get_arg_max(void)
> +{
> +    /* Since kernel 2.6.23, most architectures support argument size limit
> +     * derived from the soft RLIMIT_STACK resource limit (see getrlimit(2)).
> +     * For these architectures, the total size is limited to 1/4 of the
> +     * allowed stack size. (see execve(2))
> +     *
> +     * struct rlimit r;
> +     *
> +     * getrlimit(RLIMIT_STACK, &r);
> +     * ARG_MAX = r.rlim_cur / 4;
> +     *
> +     * ARG_MAX is _NOT_ the maximum number of arguments. It is size of the
> +     * memory used to hold command line arguments and environment variables.
> +     */
> +    return sysconf(_SC_ARG_MAX);
> +}
> +
>   static void ga_wait_child(pid_t pid, int *status, Error **errp)
>   {
>       pid_t rpid;
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 6b67f16faf..47bbddd74a 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -92,6 +92,19 @@ static OpenFlags guest_file_open_modes[] = {
>       g_free(suffix); \
>   } while (0)
>   
> +size_t ga_get_arg_max(void)
> +{
> +    /* Win32 environment has different values for the ARG_MAX constant.
> +     * We'll go with the maximum here.
> +     *
> +     * https://devblogs.microsoft.com/oldnewthing/?p=41553
> +     *
> +     * ARG_MAX is _NOT_ the maximum number of arguments. It is size of the
> +     * memory used to hold command line arguments and environment variables.
> +     */
> +    return 32767;
> +}
> +
>   static OpenFlags *find_open_flag(const char *mode_str)
>   {
>       int mode;
> diff --git a/qga/commands.c b/qga/commands.c
> index 0c7d1385c2..425a4c405f 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -231,17 +231,21 @@ static char **guest_exec_get_args(const strList *entry, bool log)
>       int count = 1, i = 0;  /* reserve for NULL terminator */
>       char **args;
>       char *str; /* for logging array of arguments */
> -    size_t str_size = 1;
> +    size_t str_size = 1, arg_max;
>   
> +    arg_max = ga_get_arg_max();
>       for (it = entry; it != NULL; it = it->next) {
>           count++;
>           str_size += 1 + strlen(it->value);
> +        if (str_size >= arg_max || count >= arg_max / 2) {
> +            break;
> +        }
>       }
>   
>       str = g_malloc(str_size);
>       *str = 0;
>       args = g_malloc(count * sizeof(char *));
> -    for (it = entry; it != NULL; it = it->next) {
> +    for (it = entry; it != NULL && i < count; it = it->next) {
>           args[i++] = it->value;
>           pstrcat(str, str_size, it->value);
>           if (it->next) {
> diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
> index 60eae16f27..300ff7e482 100644
> --- a/qga/guest-agent-core.h
> +++ b/qga/guest-agent-core.h
> @@ -46,6 +46,8 @@ const char *ga_fsfreeze_hook(GAState *s);
>   int64_t ga_get_fd_handle(GAState *s, Error **errp);
>   int ga_parse_whence(GuestFileWhence *whence, Error **errp);
>   
> +size_t ga_get_arg_max(void);
> +
>   #ifndef _WIN32
>   void reopen_fd_to_null(int fd);
>   #endif


