Received: from eggs.gnu.org ([2001:4830:134:3::10]:47945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZv1K-00078c-M0
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 02:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZv1H-0000qP-F6
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 02:44:30 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cZv1H-0000qI-9I
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 02:44:27 -0500
Received: by mail-pf0-x242.google.com with SMTP id 19so3112292pfo.3
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 23:44:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170203170925.12554-1-rjones@redhat.com>
	<20170203170925.12554-2-rjones@redhat.com>
	<2f5ef524-02d7-e0e8-c693-db932f8270b9@redhat.com>
	<20170203185624.GB13825@redhat.com>
	<25dc57d6-ded3-9e4a-92cf-e678d0c92a27@redhat.com>
	<20170203192244.GC13825@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21bdfce0-a140-e4ef-b2fe-4f5e188e44a4@redhat.com>
Date: Fri, 3 Feb 2017 23:44:23 -0800
MIME-Version: 1.0
In-Reply-To: <20170203192244.GC13825@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: den@openvz.org, stefanha@gmail.com, dplotnikov@virtuozzo.com, qemu-devel@nongnu.org, rkagan@virtuozzo.com



On 03/02/2017 11:22, Richard W.M. Jones wrote:
> 
> I think that the --fork option is mainly intended for command line use
> of qemu-nbd.  If you're running qemu-nbd from a program there's no
> real reason to use --fork, since you can control the fork process
> better yourself.
> 
> LISTEN_PID isn't settable from the command line.  It's also not
> settable from a shell script (as far as I can tell when I was trying
> to write a shell script to test nbdkit).  It has to be set between the
> fork and exec calls, because it is set to the qemu-nbd PID.
> 
> So I don't think --fork and socket activation are really features that
> it makes any sense to mix.

I agree it doesn't really make sense, but I also don't see why it
wouldn't work.

Paolo
