Received: from eggs.gnu.org ([2001:4830:134:3::10]:54338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fH7F6-0008Kv-G4
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fH7F3-0008Jk-E8
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:33:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47686 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fH7Eh-00084P-Nh
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:33:45 -0400
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9gG5aSPr7KmqMvgP4OZ9zOC5Z5_UnS_pP+eujDiQmZHw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <751a3b4f-55ef-dec0-aec9-6b48922b7843@redhat.com>
Date: Fri, 11 May 2018 14:33:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9gG5aSPr7KmqMvgP4OZ9zOC5Z5_UnS_pP+eujDiQmZHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/30] Misc patches for 2018-05-09
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

On 11/05/2018 14:19, Peter Maydell wrote:
> Some of my build setups barf on the new glib version requirement:
> 
>  * my aarch64 build host (a gcc compile farm machine which is running
>    Ubuntu 14.04.5 LTS and has glib 2.40.2)
>  * my windows cross compile setups (which have glib 2.34.3)
> 
> The latter could probably be fixed, but it will be a pain because
> gtk.org don't distribute prebuilt glib &c zipfiles usable for cross
> compile any more. For the former, that LTS is apparently still
> in support for another year.

Fair enough.  I suppose that for now we can still uniformly bump up to
2.34, which is enough to remove all compatibility shims except for a couple.

I'll resend the pull request without that part.

Thanks,

Paolo
