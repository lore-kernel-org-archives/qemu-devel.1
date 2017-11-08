Received: from eggs.gnu.org ([2001:4830:134:3::10]:52788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eCNws-0001rF-G4
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eCNwl-0006Gi-8J
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:51:10 -0500
Date: Wed, 8 Nov 2017 10:50:38 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171108105038.7lbzbtldh65zq22y@starbug-vm.ie.oracle.com>
References: <cover.1510093478.git.jcody@redhat.com>
	<d02d1a7eca3797d6fb1b7395b74a5ae757e53e64.1510093478.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <d02d1a7eca3797d6fb1b7395b74a5ae757e53e64.1510093478.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 2/7] block/ssh: make
 compliant with coding guidelines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, rjones@redhat.com, namei.unix@gmail.com

On Tue, Nov 07, 2017 at 05:27:19PM -0500, Jeff Cody wrote:
>Signed-off-by: Jeff Cody <jcody@redhat.com>
>Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> block/ssh.c | 32 ++++++++++++++++++--------------
> 1 file changed, 18 insertions(+), 14 deletions(-)
>
>diff --git a/block/ssh.c b/block/ssh.c
>index de81ec8..39cacc1 100644
>--- a/block/ssh.c
>+++ b/block/ssh.c
>@@ -241,7 +241,7 @@ static int parse_uri(const char *filename, QDict *options, Error **errp)
>         goto err;
>     }
>
>-    if(uri->user && strcmp(uri->user, "") != 0) {
>+    if (uri->user && strcmp(uri->user, "") != 0) {
>         qdict_put_str(options, "user", uri->user);
>     }
>
>@@ -268,7 +268,7 @@ static int parse_uri(const char *filename, QDict *options, Error **errp)
>
>  err:
>     if (uri) {
>-      uri_free(uri);
>+        uri_free(uri);
>     }
>     return -EINVAL;
> }
>@@ -342,7 +342,7 @@ static int check_host_key_knownhosts(BDRVSSHState *s,
>     libssh2_knownhost_readfile(knh, knh_file, LIBSSH2_KNOWNHOST_FILE_OPENSSH);
>
>     r = libssh2_knownhost_checkp(knh, host, port, hostkey, len,
>-                                 LIBSSH2_KNOWNHOST_TYPE_PLAIN|
>+                                 LIBSSH2_KNOWNHOST_TYPE_PLAIN |
>                                  LIBSSH2_KNOWNHOST_KEYENC_RAW,
>                                  &found);
>     switch (r) {
>@@ -405,15 +405,18 @@ static int compare_fingerprint(const unsigned char *fingerprint, size_t len,
>     unsigned c;
>
>     while (len > 0) {
>-        while (*host_key_check == ':')
>+        while (*host_key_check == ':') {
>             host_key_check++;
>+        }
>         if (!qemu_isxdigit(host_key_check[0]) ||
>-            !qemu_isxdigit(host_key_check[1]))
>+            !qemu_isxdigit(host_key_check[1])) {
>             return 1;
>+        }
>         c = hex2decimal(host_key_check[0]) * 16 +
>             hex2decimal(host_key_check[1]);
>-        if (c - *fingerprint != 0)
>+        if (c - *fingerprint != 0) {
>             return c - *fingerprint;
>+        }
>         fingerprint++;
>         len--;
>         host_key_check += 2;
>@@ -433,8 +436,8 @@ check_host_key_hash(BDRVSSHState *s, const char *hash,
>         return -EINVAL;
>     }
>
>-    if(compare_fingerprint((unsigned char *) fingerprint, fingerprint_len,
>-                           hash) != 0) {
>+    if (compare_fingerprint((unsigned char *) fingerprint, fingerprint_len,
>+                            hash) != 0) {
>         error_setg(errp, "remote host key does not match host_key_check '%s'",
>                    hash);
>         return -EPERM;
>@@ -507,7 +510,7 @@ static int authenticate(BDRVSSHState *s, const char *user, Error **errp)
>         goto out;
>     }
>
>-    for(;;) {
>+    for (;;) {
>         r = libssh2_agent_get_identity(agent, &identity, prev_identity);
>         if (r == 1) {           /* end of list */
>             break;
>@@ -860,8 +863,8 @@ static int ssh_create(const char *filename, QemuOpts *opts, Error **errp)
>     }
>
>     r = connect_to_ssh(&s, uri_options,
>-                       LIBSSH2_FXF_READ|LIBSSH2_FXF_WRITE|
>-                       LIBSSH2_FXF_CREAT|LIBSSH2_FXF_TRUNC,
>+                       LIBSSH2_FXF_READ  | LIBSSH2_FXF_WRITE |
>+                       LIBSSH2_FXF_CREAT | LIBSSH2_FXF_TRUNC,
>                        0644, errp);
>     if (r < 0) {
>         ret = r;
>@@ -869,7 +872,7 @@ static int ssh_create(const char *filename, QemuOpts *opts, Error **errp)
>     }
>
>     if (total_size > 0) {
>-        libssh2_sftp_seek64(s.sftp_handle, total_size-1);
>+        libssh2_sftp_seek64(s.sftp_handle, total_size - 1);
>         r2 = libssh2_sftp_write(s.sftp_handle, c, 1);
>         if (r2 < 0) {
>             sftp_error_setg(errp, &s, "truncate failed");
>@@ -1108,7 +1111,7 @@ static int ssh_write(BDRVSSHState *s, BlockDriverState *bs,
>          * works for me.
>          */
>         if (r == 0) {
>-            ssh_seek(s, offset + written, SSH_SEEK_WRITE|SSH_SEEK_FORCE);
>+            ssh_seek(s, offset + written, SSH_SEEK_WRITE | SSH_SEEK_FORCE);
>             co_yield(s, bs);
>             goto again;
>         }
>@@ -1122,8 +1125,9 @@ static int ssh_write(BDRVSSHState *s, BlockDriverState *bs,
>             end_of_vec = i->iov_base + i->iov_len;
>         }
>
>-        if (offset + written > s->attrs.filesize)
>+        if (offset + written > s->attrs.filesize) {
>             s->attrs.filesize = offset + written;
>+        }
>     }
>
>     return 0;
>-- 
>2.9.5
>
>
