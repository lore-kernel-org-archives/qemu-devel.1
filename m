Received: from eggs.gnu.org ([2001:4830:134:3::10]:45252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frm62-00036j-17
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frm5z-0001ih-9t
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:27:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1frm5z-0001h7-1I
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:27:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so14248144wmi.3
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 08:27:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20180720063109.4631-1-pbonzini@redhat.com>
Message-ID: <f5d4ea7c-0799-a30d-9afe-e5b83448011d@redhat.com>
Date: Mon, 20 Aug 2018 17:27:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180720063109.4631-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC/RFT PATCH 0/2] spice-display locking fixes
 (cursors)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 20/07/2018 08:31, Paolo Bonzini wrote:
> The first issue was found by Coverity and should be trivial.  The second
> however made me wonder how to test the code and whether it has ever
> worked, because in theory it should be an instant deadlock whenever
> qemu_spice_cursor_refresh_bh is called.
> 
> So I'm looking for help.  In fact, the changes are not tested beyond
> compilation.
> 
> Paolo
> 
> Paolo Bonzini (2):
>   spice-display: access ptr_x/ptr_y under Mutex
>   spice-display: fix qemu_spice_cursor_refresh_bh locking
> 
>  ui/spice-display.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 

Ping?

Paolo
