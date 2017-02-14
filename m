Received: from eggs.gnu.org ([2001:4830:134:3::10]:54063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cdcld-0002eO-ND
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cdclc-0005Od-SH
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:03:37 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cdclc-0005OH-MX
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:03:36 -0500
Received: by mail-wm0-x241.google.com with SMTP id u63so3455294wmu.2
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 05:03:36 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1a8cebc2-7510-0c1f-70bd-2a922c1be1a3@redhat.com>
Date: Tue, 14 Feb 2017 14:03:37 +0100
MIME-Version: 1.0
In-Reply-To: <1487006388-7966-1-git-send-email-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/12] Multifd v4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com



On 13/02/2017 18:19, Juan Quintela wrote:
> [v4]
> 
> - Address reviews
> - move synchronization to semaphores (faster).  Paolo suggestion
> - improvements overall (see invidiual patches)
> - fix all the checkpatch warnings
> - fix all [HACKS] except for one
> 
> Please review.

I think you can simplify the receive threads much more.  I left comments
on patch 11.

Paolo
