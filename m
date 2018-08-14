Received: from eggs.gnu.org ([2001:4830:134:3::10]:45488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpdbA-0007mX-8j
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpdat-00005G-TX
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:59:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49602 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpdat-0008WB-M6
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:58:59 -0400
References: <1534258018-22859-1-git-send-email-thuth@redhat.com>
	<1534258018-22859-6-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d700466-d271-f1b6-d7e4-ea82608d984f@redhat.com>
Date: Tue, 14 Aug 2018 17:33:13 +0200
MIME-Version: 1.0
In-Reply-To: <1534258018-22859-6-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] net: Silence 'has no peer' messages in
 testing mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 14/08/2018 16:46, Thomas Huth wrote:
> When running qtests with -nodefaults, we are not interested in
> these 'XYZ has no peer' messages.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  vl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 16b913f..7055df3 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4559,11 +4559,10 @@ int main(int argc, char **argv, char **envp)
>       * (2) CONFIG_SLIRP not set, in which case the implicit "-net nic"
>       * sets up a nic that isn't connected to anything.
>       */
> -    if (!default_net) {
> +    if (!default_net && (!qtest_enabled() || has_defaults)) {
>          net_check_clients();
>      }
>  

Why does it have no peer?  Not a nack, just curiosity.

Paolo
