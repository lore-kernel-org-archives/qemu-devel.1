Received: from eggs.gnu.org ([2001:4830:134:3::10]:46616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCw-0007la-HV
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCv-0004uW-BI
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:10 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUCv-0004uM-64
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:09 -0500
Received: by mail-qt0-x244.google.com with SMTP id f4so14077195qte.2
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:09 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:34 -0800
Message-Id: <20170123021748.13170-13-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 12/26] linux-user: Add HPPA definitions to
 syscall_defs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

---
 linux-user/syscall_defs.h | 131 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 957b737..39848a8 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -90,6 +90,15 @@
 #define TARGET_IOC_READ	  2U
 #define TARGET_IOC_WRITE  4U
 
+#elif defined(TARGET_HPPA)
+
+#define TARGET_IOC_SIZEBITS  14
+#define TARGET_IOC_DIRBITS    2
+
+#define TARGET_IOC_NONE   0U
+#define TARGET_IOC_WRITE  2U
+#define TARGET_IOC_READ   1U
+
 #else
 #error unsupported CPU
 #endif
@@ -417,7 +426,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     || defined(TARGET_M68K) || defined(TARGET_ALPHA) || defined(TARGET_CRIS) \
     || defined(TARGET_MICROBLAZE) || defined(TARGET_UNICORE32) \
     || defined(TARGET_S390X) || defined(TARGET_OPENRISC) \
-    || defined(TARGET_TILEGX)
+    || defined(TARGET_TILEGX) || defined(TARGET_HPPA)
 
 #if defined(TARGET_SPARC)
 #define TARGET_SA_NOCLDSTOP    8u
@@ -587,6 +596,46 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 #define TARGET_SIG_UNBLOCK	2	/* for unblocking signals */
 #define TARGET_SIG_SETMASK	3	/* for setting the signal mask */
 
+#elif defined(TARGET_HPPA)
+
+#define TARGET_SIGHUP           1
+#define TARGET_SIGINT           2
+#define TARGET_SIGQUIT          3
+#define TARGET_SIGILL           4
+#define TARGET_SIGTRAP          5
+#define TARGET_SIGABRT          6
+#define TARGET_SIGIOT           6
+#define TARGET_SIGSTKFLT        7
+#define TARGET_SIGFPE           8
+#define TARGET_SIGKILL          9
+#define TARGET_SIGBUS          10
+#define TARGET_SIGSEGV         11
+#define TARGET_SIGXCPU         12
+#define TARGET_SIGPIPE         13
+#define TARGET_SIGALRM         14
+#define TARGET_SIGTERM         15
+#define TARGET_SIGUSR1         16
+#define TARGET_SIGUSR2         17
+#define TARGET_SIGCHLD         18
+#define TARGET_SIGPWR          19
+#define TARGET_SIGVTALRM       20
+#define TARGET_SIGPROF         21
+#define TARGET_SIGIO           22
+#define TARGET_SIGPOLL         TARGET_SIGIO
+#define TARGET_SIGWINCH        23
+#define TARGET_SIGSTOP         24
+#define TARGET_SIGTSTP         25
+#define TARGET_SIGCONT         26
+#define TARGET_SIGTTIN         27
+#define TARGET_SIGTTOU         28
+#define TARGET_SIGURG          29
+#define TARGET_SIGXFSZ         30
+#define TARGET_SIGSYS          31
+
+#define TARGET_SIG_BLOCK       0
+#define TARGET_SIG_UNBLOCK     1
+#define TARGET_SIG_SETMASK     2
+
 #else
 
 /* OpenRISC Using the general signals */
@@ -1279,6 +1328,16 @@ struct target_winsize {
 #define TARGET_MAP_NORESERVE	0x10000		/* no check for reservations */
 #define TARGET_MAP_POPULATE	0x20000		/* pop (prefault) pagetables */
 #define TARGET_MAP_NONBLOCK	0x40000		/* do not block on IO */
+#elif defined(TARGET_HPPA)
+#define TARGET_MAP_ANONYMOUS	0x10		/* don't use a file */
+#define TARGET_MAP_FIXED	0x04		/* Interpret addr exactly */
+#define TARGET_MAP_GROWSDOWN	0x08000		/* stack-like segment */
+#define TARGET_MAP_DENYWRITE	0x00800		/* ETXTBSY */
+#define TARGET_MAP_EXECUTABLE	0x01000		/* mark it as an executable */
+#define TARGET_MAP_LOCKED	0x02000		/* lock the mapping */
+#define TARGET_MAP_NORESERVE	0x04000		/* no check for reservations */
+#define TARGET_MAP_POPULATE	0x10000		/* pop (prefault) pagetables */
+#define TARGET_MAP_NONBLOCK	0x20000		/* do not block on IO */
 #else
 #define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
 #define TARGET_MAP_ANONYMOUS	0x20		/* don't use a file */
@@ -2029,6 +2088,62 @@ struct target_stat64 {
     unsigned int __unused5;
 };
 
+#elif defined(TARGET_HPPA)
+
+struct target_stat {
+    abi_uint   st_dev;
+    abi_uint   st_ino;
+    abi_ushort st_mode;
+    abi_ushort st_nlink;
+    abi_ushort _res1;
+    abi_ushort _res2;
+    abi_uint   st_rdev;
+    abi_int    st_size;
+    abi_int    target_st_atime;
+    abi_uint   target_st_atime_nsec;
+    abi_int    target_st_mtime;
+    abi_uint   target_st_mtime_nsec;
+    abi_int    target_st_ctime;
+    abi_uint   target_st_ctime_nsec;
+    abi_int    st_blksize;
+    abi_int    st_blocks;
+    abi_uint   _unused1;
+    abi_uint   _unused2;
+    abi_uint   _unused3;
+    abi_uint   _unused4;
+    abi_ushort _unused5;
+    abi_short  st_fstype;
+    abi_uint   st_realdev;
+    abi_ushort st_basemode;
+    abi_ushort _unused6;
+    abi_uint   st_uid;
+    abi_uint   st_gid;
+    abi_uint   _unused7[3];
+};
+
+#define TARGET_HAS_STRUCT_STAT64
+struct target_stat64 {
+    uint64_t   st_dev;
+    abi_uint   _pad1;
+    abi_uint   _res1;
+    abi_uint   st_mode;
+    abi_uint   st_nlink;
+    abi_uint   st_uid;
+    abi_uint   st_gid;
+    uint64_t   st_rdev;
+    abi_uint   _pad2;
+    int64_t    st_size;
+    abi_int    st_blksize;
+    int64_t    st_blocks;
+    abi_int    target_st_atime;
+    abi_uint   target_st_atime_nsec;
+    abi_int    target_st_mtime;
+    abi_uint   target_st_mtime_nsec;
+    abi_int    target_st_ctime;
+    abi_uint   target_st_ctime_nsec;
+    uint64_t   st_ino;
+};
+
 #else
 #error unsupported CPU
 #endif
@@ -2273,6 +2388,20 @@ struct target_statfs64 {
 #define TARGET_O_CLOEXEC     010000000
 #define TARGET___O_SYNC      020000000
 #define TARGET_O_PATH        040000000
+#elif defined(TARGET_HPPA)
+#define TARGET_O_NONBLOCK    000200004 /* HPUX has separate NDELAY & NONBLOCK */
+#define TARGET_O_APPEND      000000010
+#define TARGET_O_CREAT       000000400 /* not fcntl */
+#define TARGET_O_EXCL        000002000 /* not fcntl */
+#define TARGET_O_NOCTTY      000400000 /* not fcntl */
+#define TARGET_O_DSYNC       001000000
+#define TARGET_O_LARGEFILE   000004000
+#define TARGET_O_DIRECTORY   000010000 /* must be a directory */
+#define TARGET_O_NOFOLLOW    000000200 /* don't follow links */
+#define TARGET_O_NOATIME     004000000
+#define TARGET_O_CLOEXEC     010000000
+#define TARGET___O_SYNC      000100000
+#define TARGET_O_PATH        020000000
 #elif defined(TARGET_ARM) || defined(TARGET_M68K)
 #define TARGET_O_DIRECTORY      040000 /* must be a directory */
 #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
-- 
2.9.3
