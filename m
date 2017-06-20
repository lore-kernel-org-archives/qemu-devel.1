Received: from eggs.gnu.org ([2001:4830:134:3::10]:45970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNfS-0005Ok-RH
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNfP-000723-Of
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:14:22 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNNfP-000715-Hq
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:14:19 -0400
Received: by mail-pf0-x242.google.com with SMTP id y7so25015418pfd.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 11:14:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497937927-19738-1-git-send-email-thuth@redhat.com>
	<1497937927-19738-9-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d76ab927-ba90-f8d1-000d-b596edeccfcb@twiddle.net>
Date: Tue, 20 Jun 2017 11:14:16 -0700
MIME-Version: 1.0
In-Reply-To: <1497937927-19738-9-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 8/8] hw/misc/edu: Compile the edu device
 as common object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 06/19/2017 10:52 PM, Thomas Huth wrote:
> edu.c does not contain any target-specific code, so we can put
> it into common-obj-y to compile it only once for all targets.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Isn't CONFIG_EDU defined by the target, via pci.conf?
Would it ever be set generically?


r~
