Received: from eggs.gnu.org ([2001:4830:134:3::10]:51771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBBgH-0002Rm-5O
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBBgC-00012i-GI
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:05:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57716 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBBgC-00012O-Aw
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:05:16 -0400
References: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524592709-6553-10-git-send-email-ian.jackson@eu.citrix.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fd03c116-d700-0466-d4c6-8054105604e1@redhat.com>
Date: Wed, 25 Apr 2018 06:05:12 +0200
MIME-Version: 1.0
In-Reply-To: <1524592709-6553-10-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/16] os-posix: cleanup: Replace fprintfs
 with error_report in change_process_uid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

On 24.04.2018 19:58, Ian Jackson wrote:
> I'm going to be editing this function and it makes sense to clean up
> this style problem in advance.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Daniel P. Berrange <berrange@redhat.com>
> CC: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  os-posix.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/os-posix.c b/os-posix.c
> index b9c2343..560db95 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -167,20 +167,20 @@ static void change_process_uid(void)
>  {
>      if (user_pwd) {
>          if (setgid(user_pwd->pw_gid) < 0) {
> -            fprintf(stderr, "Failed to setgid(%d)\n", user_pwd->pw_gid);
> +            error_report("Failed to setgid(%d)", user_pwd->pw_gid);
>              exit(1);
>          }
>          if (initgroups(user_pwd->pw_name, user_pwd->pw_gid) < 0) {
> -            fprintf(stderr, "Failed to initgroups(\"%s\", %d)\n",
> -                    user_pwd->pw_name, user_pwd->pw_gid);
> +            error_report("Failed to initgroups(\"%s\", %d)",
> +                         user_pwd->pw_name, user_pwd->pw_gid);
>              exit(1);
>          }
>          if (setuid(user_pwd->pw_uid) < 0) {
> -            fprintf(stderr, "Failed to setuid(%d)\n", user_pwd->pw_uid);
> +            error_report("Failed to setuid(%d)", user_pwd->pw_uid);
>              exit(1);
>          }
>          if (setuid(0) != -1) {
> -            fprintf(stderr, "Dropping privileges failed\n");
> +            error_report("Dropping privileges failed");
>              exit(1);
>          }
>      }
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
