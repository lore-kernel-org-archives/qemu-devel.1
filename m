Received: from eggs.gnu.org ([2001:4830:134:3::10]:35311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUzut-0004vk-Di
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUzuo-0003Fw-HW
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:06:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gUzuo-0003FL-5y
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:06:30 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-11-git-send-email-pbonzini@redhat.com>
	<df1c9b60-9ad1-7820-cee7-3daf4816b130@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1af2f8b-3bec-a222-be97-705d9956d8b7@redhat.com>
Date: Thu, 6 Dec 2018 21:06:25 +0100
MIME-Version: 1.0
In-Reply-To: <df1c9b60-9ad1-7820-cee7-3daf4816b130@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/71] vhost-user-test: skip if there is no
 memory at address 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 06/12/18 17:26, Thomas Huth wrote:
> g_test_skip does not work with older versions of the gtester ... so this
> patch series depends on your gtester replacement patches first?

Yes, that's how I got into that other mess. :)

Paolo
