Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AF6C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 10:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3AE42175B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 10:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AE42175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51083 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIsO9-0007hN-Tj
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 06:10:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIsK6-0004dL-NY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIs8f-00040N-3S
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:54:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIs8e-000404-9y
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:54:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so19351978wrx.9
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 02:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ZFYWe0PFTVI7X2Bw76Ye+VToFcQrBPO2iRompV2p7gg=;
	b=fWT2ZLi/3soAKxbYCzVRxBaFYljg2PJXAp5ioOVbDy3/ksy1L5ihUk09Mo6DdVN4BD
	M64Nte56OK9erLlcsvUy25tHqOndFj+9wAz2OU3mNaajG2Zk5hRVCsWvvXwHauKFsvue
	BGuvA9IHUDVBqoxPO5Qlxzku86qsQ9CyGYqIwMC3YpCWhxBqd+NrkzVvb0Xkp1Q9ostS
	QI1yww4Sg9PJKJKAf+S8H9jJ0ip2DXHv+CsSuXW7zr5C4OUU5G/SSWpse2G+JX7NwBXp
	1T+c15KuanglHD6+uz/+anqBCphQRYR1k60ha28I7hN4IJh/MCvOGYKg60XsDD/2kRFI
	C5SQ==
X-Gm-Message-State: APjAAAWnw+6rSSdSr2rmk6i1sLKZa6A1C7GxdAUUHP11sAL3URydTfeV
	aQBXYDg/8JGRJlnE+rwhrRpGng==
X-Google-Smtp-Source: APXvYqzWw924cBDLAztl0o38Dy5LFAXm1A7TQtDt26Kox/hfeQ7yFpIbrKej8ay3edkL/RrE/4NwVQ==
X-Received: by 2002:adf:f749:: with SMTP id z9mr221184wrp.218.1556013295154;
	Tue, 23 Apr 2019 02:54:55 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	d18sm1165372wrx.56.2019.04.23.02.54.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 02:54:54 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
	"Daniel P. Berrange" <berrange@redhat.com>
References: <20190417053225.27505-1-richard.henderson@linaro.org>
	<20190417053225.27505-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fb4917eb-4ff3-7a93-cbcd-39d1800827e8@redhat.com>
Date: Tue, 23 Apr 2019 11:54:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417053225.27505-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 1/1] util/path: Do not cache all filenames
 at startup
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu, evgreen@chromium.org,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423095453.7PjtuW4m4qcGG-TqmccBe0fZd4K-jBUQHQA1cR1333w@z>

Hi Richard, Daniel,

On 4/17/19 7:32 AM, Richard Henderson wrote:
> If one uses -L $PATH to point to a full chroot, the startup time
> is significant.  In addition, the existing probing algorithm fails
> to handle symlink loops.
> 
> Instead, probe individual paths on demand.  Cache both positive
> and negative results within $PATH, so that any one filename is
> probed only once.
> 
> Use glib filename functions for clarity.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  util/path.c | 211 ++++++++++++++--------------------------------------
>  1 file changed, 57 insertions(+), 154 deletions(-)
> 
> diff --git a/util/path.c b/util/path.c
> index 7f9fc272fb..09f75f100a 100644
> --- a/util/path.c
> +++ b/util/path.c
> @@ -8,170 +8,73 @@
>  #include <dirent.h>
>  #include "qemu/cutils.h"
>  #include "qemu/path.h"
> +#include "qemu/thread.h"
>  
> -struct pathelem
> -{
> -    /* Name of this, eg. lib */
> -    char *name;
> -    /* Full path name, eg. /usr/gnemul/x86-linux/lib. */
> -    char *pathname;
> -    struct pathelem *parent;
> -    /* Children */
> -    unsigned int num_entries;
> -    struct pathelem *entries[0];
> -};
> -
> -static struct pathelem *base;
> -
> -/* First N chars of S1 match S2, and S2 is N chars long. */
> -static int strneq(const char *s1, unsigned int n, const char *s2)
> -{
> -    unsigned int i;
> -
> -    for (i = 0; i < n; i++)
> -        if (s1[i] != s2[i])
> -            return 0;
> -    return s2[i] == 0;
> -}
> -
> -static struct pathelem *add_entry(struct pathelem *root, const char *name,
> -                                  unsigned type);
> -
> -static struct pathelem *new_entry(const char *root,
> -                                  struct pathelem *parent,
> -                                  const char *name)
> -{
> -    struct pathelem *new = g_malloc(sizeof(*new));
> -    new->name = g_strdup(name);
> -    new->pathname = g_strdup_printf("%s/%s", root, name);
> -    new->num_entries = 0;
> -    return new;
> -}
> -
> -#define streq(a,b) (strcmp((a), (b)) == 0)
> -
> -/* Not all systems provide this feature */
> -#if defined(DT_DIR) && defined(DT_UNKNOWN) && defined(DT_LNK)
> -# define dirent_type(dirent) ((dirent)->d_type)
> -# define is_dir_maybe(type) \
> -    ((type) == DT_DIR || (type) == DT_UNKNOWN || (type) == DT_LNK)
> -#else
> -# define dirent_type(dirent) (1)
> -# define is_dir_maybe(type)  (type)
> -#endif
> -
> -static struct pathelem *add_dir_maybe(struct pathelem *path)
> -{
> -    DIR *dir;
> -
> -    if ((dir = opendir(path->pathname)) != NULL) {
> -        struct dirent *dirent;
> -
> -        while ((dirent = readdir(dir)) != NULL) {
> -            if (!streq(dirent->d_name,".") && !streq(dirent->d_name,"..")){
> -                path = add_entry(path, dirent->d_name, dirent_type(dirent));
> -            }
> -        }
> -        closedir(dir);
> -    }
> -    return path;
> -}
> -
> -static struct pathelem *add_entry(struct pathelem *root, const char *name,
> -                                  unsigned type)
> -{
> -    struct pathelem **e;
> -
> -    root->num_entries++;
> -
> -    root = g_realloc(root, sizeof(*root)
> -                   + sizeof(root->entries[0])*root->num_entries);
> -    e = &root->entries[root->num_entries-1];
> -
> -    *e = new_entry(root->pathname, root, name);
> -    if (is_dir_maybe(type)) {
> -        *e = add_dir_maybe(*e);
> -    }
> -
> -    return root;
> -}
> -
> -/* This needs to be done after tree is stabilized (ie. no more reallocs!). */
> -static void set_parents(struct pathelem *child, struct pathelem *parent)
> -{
> -    unsigned int i;
> -
> -    child->parent = parent;
> -    for (i = 0; i < child->num_entries; i++)
> -        set_parents(child->entries[i], child);
> -}
> -
> -/* FIXME: Doesn't handle DIR/.. where DIR is not in emulated dir. */
> -static const char *
> -follow_path(const struct pathelem *cursor, const char *name)
> -{
> -    unsigned int i, namelen;
> -
> -    name += strspn(name, "/");
> -    namelen = strcspn(name, "/");
> -
> -    if (namelen == 0)
> -        return cursor->pathname;
> -
> -    if (strneq(name, namelen, ".."))
> -        return follow_path(cursor->parent, name + namelen);
> -
> -    if (strneq(name, namelen, "."))
> -        return follow_path(cursor, name + namelen);
> -
> -    for (i = 0; i < cursor->num_entries; i++)
> -        if (strneq(name, namelen, cursor->entries[i]->name))
> -            return follow_path(cursor->entries[i], name + namelen);
> -
> -    /* Not found */
> -    return NULL;
> -}
> +static const char *base;
> +static GHashTable *hash;
> +static QemuMutex lock;
>  
>  void init_paths(const char *prefix)
>  {
> -    char pref_buf[PATH_MAX];
> -
> -    if (prefix[0] == '\0' ||
> -        !strcmp(prefix, "/"))
> +    if (prefix[0] == '\0' || !strcmp(prefix, "/")) {
>          return;
> -
> -    if (prefix[0] != '/') {
> -        char *cwd = getcwd(NULL, 0);
> -        size_t pref_buf_len = sizeof(pref_buf);
> -
> -        if (!cwd)
> -            abort();
> -        pstrcpy(pref_buf, sizeof(pref_buf), cwd);
> -        pstrcat(pref_buf, pref_buf_len, "/");
> -        pstrcat(pref_buf, pref_buf_len, prefix);
> -        free(cwd);
> -    } else
> -        pstrcpy(pref_buf, sizeof(pref_buf), prefix + 1);
> -
> -    base = new_entry("", NULL, pref_buf);
> -    base = add_dir_maybe(base);
> -    if (base->num_entries == 0) {
> -        g_free(base->pathname);
> -        g_free(base->name);
> -        g_free(base);
> -        base = NULL;
> -    } else {
> -        set_parents(base, base);
>      }
> +
> +#if GLIB_CHECK_VERSION(2, 58, 0)

Should we raise GLIB_VERSION_MAX_ALLOWED in "glib-compat.h"?

Currently it is:

  /* Ask for warnings if code tries to use function that did not
   * exist in the defined version. These risk breaking builds
   */
  #define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_40

From commit e71e8cc035558eabd6b3e19f6d3254c754c027ef:

 glib: enforce the minimum required version and warn about old APIs

 There are two useful macros that can be defined before including
 glib.h that are related to the min required glib version

  - GLIB_VERSION_MIN_REQUIRED

    When this is defined, if code uses an API that was deprecated
    in this version, or older, a compiler warning will be emitted.
    This alerts maintainers to update their code to whatever new
    replacement API is now recommended best practice.

  - GLIB_VERSION_MAX_ALLOWED

    When this is defined, if code uses an API that was introduced
    in a version that is newer than the declared version, a compiler
    warning will be emitted. This alerts maintainers if new code
    accidentally uses functionality that won't be available on some
    supported platforms.

 The GLIB_VERSION_MAX_ALLOWED constant makes it a bit harder to opt
 in to using specific new APIs with a GLIB_CHECK_VERSION conditional.
 To workaround this Pragmas can be used to temporarily turn off the
 -Wdeprecated-declarations compiler warning, while a static inline
 compat function is implemented. This workaround is illustrated with the
 implementation of the g_strv_contains method to satisfy the test suite.

> +    base = g_canonicalize_filename(prefix, NULL);
> +#else
> +    if (prefix[0] != '/') {
> +        char *cwd = g_get_current_dir();
> +        base = g_build_filename(cwd, prefix, NULL);
> +        g_free(cwd);
> +    } else {
> +        base = g_strdup(prefix);
> +    }
> +#endif
> +
> +    hash = g_hash_table_new(g_str_hash, g_str_equal);
> +    qemu_mutex_init(&lock);
>  }
>  
>  /* Look for path in emulation dir, otherwise return name. */
>  const char *path(const char *name)
>  {
> -    /* Only do absolute paths: quick and dirty, but should mostly be OK.
> -       Could do relative by tracking cwd. */
> -    if (!base || !name || name[0] != '/')
> -        return name;
> +    gpointer key, value;
> +    char *ret;
>  
> -    return follow_path(base, name) ?: name;
> +    /* Only do absolute paths: quick and dirty, but should mostly be OK.  */
> +    if (!base || !name || name[0] != '/') {
> +        return name;
> +    }
> +
> +    qemu_mutex_lock(&lock);
> +
> +    /* Have we looked up this file before?  */
> +    if (g_hash_table_lookup_extended(hash, name, &key, &value)) {
> +        ret = value ? value : name;
> +    } else {
> +        char *full_name, *save_name;
> +
> +        save_name = g_strdup(name);
> +#if GLIB_CHECK_VERSION(2, 58, 0)
> +        full_name = g_canonicalize_filename(g_path_skip_root(name), base);
> +#else
> +        full_name = g_build_filename(base, name, NULL);
> +#endif
> +
> +        /* Look for the path; record the result, pass or fail.  */
> +        if (access(full_name, F_OK) == 0) {
> +            /* Exists.  */
> +            g_hash_table_insert(hash, save_name, full_name);
> +            ret = full_name;
> +        } else {
> +            /* Does not exist.  */
> +            g_free(full_name);
> +            g_hash_table_insert(hash, save_name, NULL);
> +            ret = name;
> +        }
> +    }
> +
> +    qemu_mutex_unlock(&lock);
> +    return ret;
>  }
> 

