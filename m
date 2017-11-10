Received: from eggs.gnu.org ([2001:4830:134:3::10]:47630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eD4RT-0002vX-Qz
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 03:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eD4RO-000260-Vt
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 03:13:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eD4RO-00024V-Pv
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 03:13:30 -0500
References: <1510273811-13419-1-git-send-email-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <537cd77a-41ef-cf05-e835-160a08c53bf5@redhat.com>
Date: Fri, 10 Nov 2017 09:13:23 +0100
MIME-Version: 1.0
In-Reply-To: <1510273811-13419-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] thread-posix: fix qemu_rec_mutex_trylock
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 10/11/2017 01:30, Emilio G. Cota wrote:
> We never noticed because it has no users.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qemu/thread-posix.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
> index f4296d3..f3f47e4 100644
> --- a/include/qemu/thread-posix.h
> +++ b/include/qemu/thread-posix.h
> @@ -7,7 +7,7 @@
>  typedef QemuMutex QemuRecMutex;
>  #define qemu_rec_mutex_destroy qemu_mutex_destroy
>  #define qemu_rec_mutex_lock qemu_mutex_lock
> -#define qemu_rec_mutex_try_lock qemu_mutex_try_lock
> +#define qemu_rec_mutex_trylock qemu_mutex_trylock
>  #define qemu_rec_mutex_unlock qemu_mutex_unlock
>  
>  struct QemuMutex {
> 

Queued, thanks.

Paolo
