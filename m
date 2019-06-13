Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079F4C31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80742054F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80742054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40816 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRVY-00023t-4L
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54547)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hbPxt-0003rC-HI
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hbPxn-0005Ro-OD
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:40:27 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50829)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hbPxl-0005Nn-DK
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:40:23 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MjSHc-1iLFBD1STy-00l0uA; Thu, 13 Jun 2019 15:40:17 +0200
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190519201953.20161-1-richard.henderson@linaro.org>
 <20190519201953.20161-2-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <c307ce5c-1eb4-d26b-d9a6-6579b7d6bcf0@vivier.eu>
Date: Thu, 13 Jun 2019 15:40:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190519201953.20161-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WcSBLS37zdrLcR48/DIYRQNIRaWZUhjzungkQQNm0oFNB1V5MHm
 tQnvevrqogHXV6z+2QUDO/xJmFka9879zeNCOWHHZD6tar1KdO7hxEATDgqZMi2Ws98m1M9
 tQEvWHCpTTlRTKzyqlTei9UvNsYueVeNl3q7O3UERk2ceFLkxAE9JwRKePSGZeBF8VgcTHH
 rX0Kp0d2Quho2e2rHmDKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5DBNCfX1tgM=:im0ykGCT67SKtct8BZO0OY
 DCMeN5w7DtXEibL8Q8m54+T74fzhU3mghsjjuuXvJj7iuzP5ZdcqgZPmT5p1Uk4QXwyb63gCz
 q0JdF4XCJtvPaxC58j0T6wdmLBF3j235aeyXo+d7yWEvU3GqHX/sx/HvFaMJL/xrBLIZV9PrS
 Fg2v6om/cneO0nW3FTvjNlP2gCTanSAV41hwyD+vBjBHqu9MvjHr/2ekZdBjP67Sl5UEUT1me
 3NFRzgmwrCqUqdOOIj0U7BYOdP5Q9Dai9eqe/4zs/kToVWXyVO07UKeakqbxJDi4g+c3iot1C
 txs/BMJUc/6DCLmVih6ns2kdkmrP+uGJMiHgN5+vGGqiglX+DcBEZldloI6zfTw3JzuIc6hPh
 0jPdSNuwHnDWPxjF/8fSF2RsIVsgy/tmUdksoF/Jspbap6GPoig+hL0LvSIrbqRE4o7t14vYf
 awPJUvOgDUsX7XhGYNxnPJ7oSD5mcxGb25bx0ZNgLUe4vlU6xG71U3CDe2pfStYMmO4Fg0t6w
 eLX15Q8giLgOGXeHwK7nHuYVypvkzjSbBvQNZSuUM0E1pQ1s9T/a5Ch8cLQsPvmzDGMPZCN7r
 gCKe3uYhYSEl9I8HLC48GkPHgHox4wdQMIXEuVdeqef7wZYOJVKF73WOLVk+p43/ryuoVAUWW
 LpagFkK67TZkFafVnNgJV7Wn+sXGbu/1OdYlcMeE05c7y+mwkedEnVkpdFqNGkjG+S3WT1r6S
 rjb12gvafJcmSwqvdGvafyxU3Q3arDAtF4VsljscQ4QUdEqY+s1FWVldGH4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [PATCH 01/13] util/path: Do not cache all
 filenames at startup
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

Le 19/05/2019 à 22:19, Richard Henderson a écrit :
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
>  util/path.c | 201 ++++++++++++----------------------------------------
>  1 file changed, 47 insertions(+), 154 deletions(-)
> 
> diff --git a/util/path.c b/util/path.c
> index 7f9fc272fb..8e174eb436 100644
> --- a/util/path.c
> +++ b/util/path.c
> @@ -8,170 +8,63 @@
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
> +    if (prefix[0] == '/') {
> +        base = g_strdup(prefix);
> +    } else {
> +        char *cwd = g_get_current_dir();
> +        base = g_build_filename(cwd, prefix, NULL);
> +        g_free(cwd);
> +    }
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
> +    const char *ret;
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
> +        char *save = g_strdup(name);
> +        char *full = g_build_filename(base, name, NULL);
> +
> +        /* Look for the path; record the result, pass or fail.  */
> +        if (access(full, F_OK) == 0) {
> +            /* Exists.  */
> +            g_hash_table_insert(hash, save, full);
> +            ret = full;
> +        } else {
> +            /* Does not exist.  */
> +            g_free(full);
> +            g_hash_table_insert(hash, save, NULL);
> +            ret = name;
> +        }
> +    }
> +
> +    qemu_mutex_unlock(&lock);
> +    return ret;
>  }
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent

