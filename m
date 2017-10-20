Received: from eggs.gnu.org ([2001:4830:134:3::10]:43123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5UgC-0001eS-CQ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5Ug8-0006UG-Cm
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:37:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e5Ug8-0006TP-6Y
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:37:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54F58C0587C4
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 10:37:22 +0000 (UTC)
References: <20171020101219.2378-1-pbonzini@redhat.com>
	<1b56a63f-ab38-219b-6b2c-2a43c343e5f0@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <03c6bfa2-77b1-8ab6-482b-466aa2ac96b7@redhat.com>
Date: Fri, 20 Oct 2017 12:37:20 +0200
MIME-Version: 1.0
In-Reply-To: <1b56a63f-ab38-219b-6b2c-2a43c343e5f0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] build: disable -Wmissing-braces on older
 compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

On 20/10/2017 12:27, Laszlo Ersek wrote:
>> +if compile_object "-Werror" "" ; then
>> +  :
>> +else
> Is this an established idiom for the configure script, in place of:
> 
>   if ! compile_object "-Werror" "" ; then
> 
> ?
> 
> Looks good to me otherwise.

I tend not use "if !".  In general that's just me, but in this case I
think it's useful to point out that a successful compile does nothing;
generally it's the successful compile that adjusts command line arguments.

Paolo
