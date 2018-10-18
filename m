Received: from eggs.gnu.org ([2001:4830:134:3::10]:35866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9KP-0005Sr-5h
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9KM-0006Uc-0D
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gD9KI-0006M0-2D
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:03 -0400
References: <20181018123332.23518-1-pbonzini@redhat.com>
	<CAFEAcA_6jGoD3-iTwc7=RUrYc1ac7jcjA8m26-JpRrcW+P-qRQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b2eae8c0-4a83-b34d-3d34-878e27de080c@redhat.com>
Date: Thu, 18 Oct 2018 16:30:54 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_6jGoD3-iTwc7=RUrYc1ac7jcjA8m26-JpRrcW+P-qRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-i386: kvm: do not initialize
 padding fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18/10/2018 15:03, Peter Maydell wrote:
>  * these initializers were added by commit 7e680753cfa2
>    in order to suppress a valgrind warning
>  * they were rendered unnecessary by the later commit 076796f8fd27f4d,
>    which added the "= {}" initializer to the declaration of "events",
>    thus zero-initializing the whole struct (and so this patch does
>    not change behaviour at all)

Will do, thanks.

Paolo
