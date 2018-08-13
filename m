Received: from eggs.gnu.org ([2001:4830:134:3::10]:43019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fp9qA-0005LO-ME
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fp9q5-0000xE-NJ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:12:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48252 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fp9q5-0000wx-HG
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:12:41 -0400
References: <20180813093402.10852-1-jusual@mail.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e9bc37b7-f91d-a50d-bddf-8b3d0fbd3412@redhat.com>
Date: Mon, 13 Aug 2018 12:12:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180813093402.10852-1-jusual@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] chardev/char-fe: Fix typos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

On 13/08/2018 11:34, Julia Suvorova wrote:
> Fixup some typos in the comments.
> 
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  include/chardev/char-fe.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index 71cd069478..c67271f1ba 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h
> @@ -113,7 +113,7 @@ void qemu_chr_fe_accept_input(CharBackend *be);
>  /**
>   * @qemu_chr_fe_disconnect:
>   *
> - * Close a fd accpeted by character backend.
> + * Close a fd accepted by character backend.
>   * Without associated Chardev, do nothing.
>   */
>  void qemu_chr_fe_disconnect(CharBackend *be);
> @@ -122,7 +122,7 @@ void qemu_chr_fe_disconnect(CharBackend *be);
>   * @qemu_chr_fe_wait_connected:
>   *
>   * Wait for characted backend to be connected, return < 0 on error or
> - * if no assicated Chardev.
> + * if no associated Chardev.
>   */
>  int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp);
>  
> @@ -186,7 +186,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
>   * @buf the data
>   * @len the number of bytes to send
>   *
> - * Returns: the number of bytes consumed (0 if no assicated Chardev)
> + * Returns: the number of bytes consumed (0 if no associated Chardev)
>   */
>  int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
>  
> @@ -201,7 +201,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
>   * @buf the data
>   * @len the number of bytes to send
>   *
> - * Returns: the number of bytes consumed (0 if no assicated Chardev)
> + * Returns: the number of bytes consumed (0 if no associated Chardev)
>   */
>  int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
>  
> @@ -213,7 +213,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
>   * @buf the data buffer
>   * @len the number of bytes to read
>   *
> - * Returns: the number of bytes read (0 if no assicated Chardev)
> + * Returns: the number of bytes read (0 if no associated Chardev)
>   */
>  int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len);
>  
> 

Queued, thanks.

Paolo
