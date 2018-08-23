Received: from eggs.gnu.org ([2001:4830:134:3::10]:50163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fslP3-00054j-LV
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fsl9Z-0006tf-Ey
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:39:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48068 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fsl9Z-0006t2-8j
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:39:41 -0400
References: <20180822103835.26129-1-pbonzini@redhat.com>
	<20180822220928.jcl7df2kbrcgk7c6@MacBook-Pro-Roman.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <331f6f39-98bb-9392-4582-b3e26dafac0f@redhat.com>
Date: Thu, 23 Aug 2018 10:39:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180822220928.jcl7df2kbrcgk7c6@MacBook-Pro-Roman.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] char-pty: remove unnecessary #ifdef
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: qemu-devel@nongnu.org

On 23/08/2018 00:12, Roman Bolshakov wrote:
> On Wed, Aug 22, 2018 at 12:38:35PM +0200, Paolo Bonzini wrote:
>> For some reason __APPLE__ was not checked in pty code.  However, the #ifdef
>> is redundant: this file is already compiled only if CONFIG_POSIX, same as
>> util/qemu-openpty.c which it uses.
>>
> 
> Thanks Paolo!
> 
> FWIW, qemu_openpty_raw and qemu_pipe are declared for all operating
> systems except _WIN32 in qemu-common.h. For sake of symmetry, should the
> declarations be available only for CONFIG_POSIX?

I would even move them out of qemu-common.h to a separate qemu/openpty.h
file...

Paolo
