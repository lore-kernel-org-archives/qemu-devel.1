Received: from eggs.gnu.org ([2001:4830:134:3::10]:33470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gadPD-0000V4-I2
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:17:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gadP9-0007q8-1k
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:17:11 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:46938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gadP8-0007pj-Qu
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:17:06 -0500
Received: by mail-wr1-f51.google.com with SMTP id l9so7445344wrt.13
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:17:06 -0800 (PST)
References: <f10356c5-c6db-8019-62e4-8ef41e607bf1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa77e2fd-d6ac-52a5-0a00-f69c90c27ded@redhat.com>
Date: Sat, 22 Dec 2018 10:17:04 +0100
MIME-Version: 1.0
In-Reply-To: <f10356c5-c6db-8019-62e4-8ef41e607bf1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Segfaults in chardev due to races
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 21/12/18 23:31, Max Reitz wrote:
> I suppose the issue is that QMP events are sent by one thread, and
> client disconnects are handled by a different one.  So if a QMP event is
> sent while a client disconnects concurrently, races may occur; and the
> only protection against concurrent access appears to be the
> chr_write_lock, which I don't think is enough.

I think disconnection (tcp_chr_disconnect) has to take the
chr_write_lock too.

Paolo
