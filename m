Received: from eggs.gnu.org ([2001:4830:134:3::10]:40215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cdcIv-0002uo-45
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cdcIq-0007c4-9N
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:33:57 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cdcIq-0007aB-33
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:33:52 -0500
Received: by mail-wm0-x243.google.com with SMTP id r18so3329446wmd.3
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:33:50 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-8-git-send-email-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c9934bf-7df3-6a81-caac-e949ca89ceaf@redhat.com>
Date: Tue, 14 Feb 2017 13:33:50 +0100
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/24] util/cutils: Clean up variable names
 around qemu_strtol()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org



On 14/02/2017 11:25, Markus Armbruster wrote:
> * qemu_strtol()'s variable @err is *negative* errno,
>   check_strtox_error()'s parameter @err is *positive*.  Rename the
>   latter to @eno.

What about in_errno or libc_errno?  No need to repost of course.

Paolo
