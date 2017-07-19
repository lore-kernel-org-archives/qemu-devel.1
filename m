Received: from eggs.gnu.org ([2001:4830:134:3::10]:48212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXtOR-0005wl-3z
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXtOO-0004Lt-0D
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:08:15 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXtON-0004LZ-Ra
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:08:11 -0400
Received: by mail-qt0-x242.google.com with SMTP id l55so1136558qtl.3
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 11:08:11 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500468850-15571-1-git-send-email-thuth@redhat.com>
	<1500468850-15571-4-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c452c67f-6519-ae89-e26b-9699cdb18c93@twiddle.net>
Date: Wed, 19 Jul 2017 08:08:05 -1000
MIME-Version: 1.0
In-Reply-To: <1500468850-15571-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] target/s390x: Move diag helpers to a
 separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 07/19/2017 02:54 AM, Thomas Huth wrote:
> misc_helper.c won't be compiled with --disable-tcg anymore, but we
> still need the diag helpers in KVM builds, too, so move the helper
> functions to a separate file.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   target/s390x/Makefile.objs |   2 +-
>   target/s390x/diag.c        | 179 +++++++++++++++++++++++++++++++++++++++++++++
>   target/s390x/misc_helper.c | 167 ------------------------------------------
>   3 files changed, 180 insertions(+), 168 deletions(-)
>   create mode 100644 target/s390x/diag.c

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
