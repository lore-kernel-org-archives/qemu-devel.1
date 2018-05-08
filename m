Received: from eggs.gnu.org ([2001:4830:134:3::10]:43156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG8Td-0006vC-HU
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG8Ta-0002Tc-DB
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:40:45 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59039)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fG8Ta-0002Rh-2i
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:40:42 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  8 May 2018 21:40:24 +0200
Message-Id: <20180508194026.1281-4-laurent@vivier.eu>
In-Reply-To: <20180508194026.1281-1-laurent@vivier.eu>
References: <20180508194026.1281-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 3/5] linux-user: update sparc/syscall_nr.h to
 linux header 4.16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

And kill sys_aplib, add sys_sync_file_range:
on sparc, since linux 2.6.17, aplib syscall has been replaced
 by sync_file_range syscall.
(289eee6fa78e ["SPARC]: Wire up sys_sync_file_range() into syscall tables.")
The syscall has been removed in linux v2.5.71
(6196166fad "[SPARC64]: Kill sys_aplib.")

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/syscall_nr.h   | 32 +++++++++++++++++++++++++++++++-
 linux-user/sparc64/syscall_nr.h | 20 ++++++++++++--------
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/linux-user/sparc/syscall_nr.h b/linux-user/sparc/syscall_nr.h
index e713c9d5f4..2d77e19bec 100644
--- a/linux-user/sparc/syscall_nr.h
+++ b/linux-user/sparc/syscall_nr.h
@@ -22,6 +22,7 @@
 #define TARGET_NR_capset		 22 /* Linux Specific				   */
 #define TARGET_NR_setuid              23 /* Implemented via setreuid in SunOS           */
 #define TARGET_NR_getuid              24 /* Common                                      */
+#define TARGET_NR_vmsplice            25
 #define TARGET_NR_ptrace              26 /* Common                                      */
 #define TARGET_NR_alarm               27 /* Implemented via setitimer in SunOS          */
 #define TARGET_NR_sigaltstack	 28 /* Common					   */
@@ -135,6 +136,7 @@
 #define TARGET_NR_rmdir              137 /* Common                                      */
 #define TARGET_NR_utimes             138 /* SunOS Specific                              */
 #define TARGET_NR_stat64		139 /* Linux sparc32 Specific			   */
+#define TARGET_NR_sendfile64         140
 #define TARGET_NR_getpeername        141 /* Common                                      */
 #define TARGET_NR_futex              142 /* gethostid under SunOS                       */
 #define TARGET_NR_gettid             143 /* ENOSYS under SunOS                          */
@@ -145,29 +147,51 @@
 #define TARGET_NR_pciconfig_read	148 /* ENOSYS under SunOS                          */
 #define TARGET_NR_pciconfig_write	149 /* ENOSYS under SunOS                          */
 #define TARGET_NR_getsockname        150 /* Common                                      */
+#define TARGET_NR_inotify_init       151
+#define TARGET_NR_inotify_add_watch  152
 #define TARGET_NR_poll               153 /* Common                                      */
 #define TARGET_NR_getdents64		154 /* Linux specific				   */
 #define TARGET_NR_fcntl64		155 /* Linux sparc32 Specific                      */
+#define TARGET_NR_inotify_rm_watch   156
 #define TARGET_NR_statfs             157 /* Common                                      */
 #define TARGET_NR_fstatfs            158 /* Common                                      */
 #define TARGET_NR_umount             159 /* Common                                      */
+#define TARGET_NR_sched_set_affinity 160
+#define TARGET_NR_sched_get_affinity 161
 #define TARGET_NR_getdomainname      162 /* SunOS Specific                              */
 #define TARGET_NR_setdomainname      163 /* Common                                      */
 #define TARGET_NR_quotactl           165 /* Common                                      */
 #define TARGET_NR_set_tid_address    166 /* Linux specific, exportfs under SunOS        */
 #define TARGET_NR_mount              167 /* Common                                      */
 #define TARGET_NR_ustat              168 /* Common                                      */
+#define TARGET_NR_setxattr           169
+#define TARGET_NR_lsetxattr          170
+#define TARGET_NR_fsetxattr          171
+#define TARGET_NR_getxattr           172
+#define TARGET_NR_lgetxattr          173
 #define TARGET_NR_getdents           174 /* Common                                      */
 #define TARGET_NR_setsid             175 /* Common                                      */
 #define TARGET_NR_fchdir             176 /* Common                                      */
+#define TARGET_NR_fgetxattr          177
+#define TARGET_NR_listxattr          178
+#define TARGET_NR_llistxattr         179
+#define TARGET_NR_flistxattr         180
+#define TARGET_NR_removexattr        181
+#define TARGET_NR_lremovexattr       182
 #define TARGET_NR_sigpending         183 /* Common                                      */
 #define TARGET_NR_query_module	184 /* Linux Specific				   */
 #define TARGET_NR_setpgid            185 /* Common                                      */
+#define TARGET_NR_fremovexattr       186
 #define TARGET_NR_tkill              187 /* SunOS: fpathconf                            */
 #define TARGET_NR_exit_group	     188 /* Linux specific, sysconf undef SunOS         */
 #define TARGET_NR_uname              189 /* Linux Specific                              */
 #define TARGET_NR_init_module        190 /* Linux Specific                              */
 #define TARGET_NR_personality        191 /* Linux Specific                              */
+#define TARGET_NR_remap_file_pages   192
+#define TARGET_NR_epoll_create       193
+#define TARGET_NR_epoll_ctl          194
+#define TARGET_NR_epoll_wait         195
+#define TARGET_NR_ioprio_set         196
 #define TARGET_NR_getppid            197 /* Linux Specific                              */
 #define TARGET_NR_sigaction          198 /* Linux Specific                              */
 #define TARGET_NR_sgetmask           199 /* Linux Specific                              */
@@ -189,6 +213,7 @@
 #define TARGET_NR_ipc                215 /* Linux Specific                              */
 #define TARGET_NR_sigreturn          216 /* Linux Specific                              */
 #define TARGET_NR_clone              217 /* Linux Specific                              */
+#define TARGET_NR_ioprio_get         218
 #define TARGET_NR_adjtimex           219 /* Linux Specific                              */
 #define TARGET_NR_sigprocmask        220 /* Linux Specific                              */
 #define TARGET_NR_create_module      221 /* Linux Specific                              */
@@ -202,6 +227,7 @@
 #define TARGET_NR_setfsgid           229 /* Linux Specific                              */
 #define TARGET_NR__newselect         230 /* Linux Specific                              */
 #define TARGET_NR_time               231 /* Linux Specific                              */
+#define TARGET_NR_splice             232
 #define TARGET_NR_stime              233 /* Linux Specific                              */
 #define TARGET_NR_statfs64           234 /* Linux Specific                              */
 #define TARGET_NR_fstatfs64          235 /* Linux Specific                              */
@@ -224,7 +250,7 @@
 #define TARGET_NR_getsid             252
 #define TARGET_NR_fdatasync          253
 #define TARGET_NR_nfsservctl         254
-#define TARGET_NR_aplib              255
+#define TARGET_NR_sync_file_range    255
 #define TARGET_NR_clock_settime	256
 #define TARGET_NR_clock_gettime	257
 #define TARGET_NR_clock_getres	258
@@ -326,3 +352,7 @@
 #define TARGET_NR_listen                354
 #define TARGET_NR_setsockopt            355
 #define TARGET_NR_mlock2                356
+#define TARGET_NR_copy_file_range       357
+#define TARGET_NR_preadv2               358
+#define TARGET_NR_pwritev2              359
+#define TARGET_NR_statx                 360
diff --git a/linux-user/sparc64/syscall_nr.h b/linux-user/sparc64/syscall_nr.h
index 2b49ead267..9391645598 100644
--- a/linux-user/sparc64/syscall_nr.h
+++ b/linux-user/sparc64/syscall_nr.h
@@ -23,7 +23,7 @@
 #define TARGET_NR_capset		 22 /* Linux Specific				   */
 #define TARGET_NR_setuid              23 /* Implemented via setreuid in SunOS           */
 #define TARGET_NR_getuid              24 /* Common                                      */
-/* #define TARGET_NR_time alias	 25    ENOSYS under SunOS			   */
+#define TARGET_NR_vmsplice            25
 #define TARGET_NR_ptrace              26 /* Common                                      */
 #define TARGET_NR_alarm               27 /* Implemented via setitimer in SunOS          */
 #define TARGET_NR_sigaltstack	 28 /* Common					   */
@@ -149,8 +149,8 @@
 #define TARGET_NR_pciconfig_read	148 /* ENOSYS under SunOS                          */
 #define TARGET_NR_pciconfig_write	149 /* ENOSYS under SunOS                          */
 #define TARGET_NR_getsockname        150 /* Common                                      */
-/* #define TARGET_NR_getmsg          151    SunOS Specific                              */
-/* #define TARGET_NR_putmsg          152    SunOS Specific                              */
+#define TARGET_NR_inotify_init       151
+#define TARGET_NR_inotify_add_watch  152
 #define TARGET_NR_poll               153 /* Common                                      */
 #define TARGET_NR_getdents64		154 /* Linux specific				   */
 #define TARGET_NR_fcntl64            155 /* Linux sparc32 Specific                      */
@@ -194,7 +194,7 @@
 #define TARGET_NR_epoll_create       193 /* Linux Specific                              */
 #define TARGET_NR_epoll_ctl          194 /* Linux Specific                              */
 #define TARGET_NR_epoll_wait         195 /* Linux Specific                              */
-/* #define TARGET_NR_ulimit          196    Linux Specific                              */
+#define TARGET_NR_ioprio_set         196
 #define TARGET_NR_getppid            197 /* Linux Specific                              */
 #define TARGET_NR_sigaction          198 /* Linux Specific                              */
 #define TARGET_NR_sgetmask           199 /* Linux Specific                              */
@@ -216,7 +216,7 @@
 #define TARGET_NR_ipc                215 /* Linux Specific                              */
 #define TARGET_NR_sigreturn          216 /* Linux Specific                              */
 #define TARGET_NR_clone              217 /* Linux Specific                              */
-/* #define TARGET_NR_modify_ldt      218    Linux Specific - i386 specific, unused      */
+#define TARGET_NR_ioprio_get         218
 #define TARGET_NR_adjtimex           219 /* Linux Specific                              */
 #define TARGET_NR_sigprocmask        220 /* Linux Specific                              */
 #define TARGET_NR_create_module      221 /* Linux Specific                              */
@@ -230,7 +230,7 @@
 #define TARGET_NR_setfsgid           229 /* Linux Specific                              */
 #define TARGET_NR__newselect         230 /* Linux Specific                              */
 #define TARGET_NR_time               231 /* Linux sparc32                               */
-/* #define TARGET_NR_oldstat         232    Linux Specific                              */
+#define TARGET_NR_splice             232
 #define TARGET_NR_stime              233 /* Linux Specific                              */
 #define TARGET_NR_statfs64           234 /* Linux Specific                              */
 #define TARGET_NR_fstatfs64          235 /* Linux Specific                              */
@@ -253,7 +253,7 @@
 #define TARGET_NR_getsid             252
 #define TARGET_NR_fdatasync          253
 #define TARGET_NR_nfsservctl         254
-#define TARGET_NR_aplib              255
+#define TARGET_NR_sync_file_range    255
 #define TARGET_NR_clock_settime	256
 #define TARGET_NR_clock_gettime	257
 #define TARGET_NR_clock_getres	258
@@ -310,7 +310,7 @@
 #define TARGET_NR_epoll_pwait	309
 #define TARGET_NR_utimensat		310
 #define TARGET_NR_signalfd		311
-#define TARGET_NR_timerfd		312
+#define TARGET_NR_timerfd_create        312
 #define TARGET_NR_eventfd		313
 #define TARGET_NR_fallocate		314
 #define TARGET_NR_timerfd_settime	315
@@ -355,3 +355,7 @@
 #define TARGET_NR_listen                354
 #define TARGET_NR_setsockopt            355
 #define TARGET_NR_mlock2                356
+#define TARGET_NR_copy_file_range       357
+#define TARGET_NR_preadv2               358
+#define TARGET_NR_pwritev2              359
+#define TARGET_NR_statx                 360
-- 
2.14.3
