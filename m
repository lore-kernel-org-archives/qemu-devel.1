Received: from eggs.gnu.org ([2001:4830:134:3::10]:43953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1em2MI-0008Ui-Bv
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1em2ME-0002hh-Ee
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:04:46 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180214173102.9363-1-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a3b2029e-a092-e7f7-8953-12d59b874736@twiddle.net>
Date: Wed, 14 Feb 2018 11:04:37 -0800
MIME-Version: 1.0
In-Reply-To: <20180214173102.9363-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/tcg: add various alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>

On 02/14/2018 09:31 AM, David Hildenbrand wrote:
> Let's add proper alignment checks for a handful of instructions that
> require a SPECIFICATION exception in case alignment is violated.
> 
> Introduce new wout/in functions. Declare them as "static inline" to avoid
> warnings about not being used for CONFIG_USER_ONLY (as we are right
> now only using them for privileged instructions).

Annoyingly, clang will still warn for this.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
