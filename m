Received: from eggs.gnu.org ([2001:4830:134:3::10]:33158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuKAm-0004ED-1d
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 12:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuKAh-0004NI-Va
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 12:15:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55136 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fuKAh-0004KD-NX
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 12:15:19 -0400
References: <1535381652-19870-1-git-send-email-thuth@redhat.com>
	<1535381652-19870-5-git-send-email-thuth@redhat.com>
	<CAFEAcA9xaUHZ5qg-21w9-J+9znKjTqJR+uW6B5SpMr2woWvjTA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e631fac1-373e-88d7-40b0-ff220b8c0435@redhat.com>
Date: Mon, 27 Aug 2018 18:15:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9xaUHZ5qg-21w9-J+9znKjTqJR+uW6B5SpMr2woWvjTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] net: Remove the deprecated -tftp,
 -bootp, -redir and -smb options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Paolo Bonzini <pbonzini@redhat.com>

On 2018-08-27 18:11, Peter Maydell wrote:
> On 27 August 2018 at 15:54, Thomas Huth <thuth@redhat.com> wrote:
>> These options likely do not work as expected as soon as the user
>> tries to use more than one network interface at once. The parameters
>> have been marked as deprecated since QEMU v2.6, so users had plenty
>> of time to move their scripts to the new syntax.
> 
> I still haven't changed my scripts, because the warning
> message if you use -redir still doesn't tell you what
> exactly the new syntax option equivalent is...

Oh, c'mon, I explicitly updated the documentation after you've
complained the last time:

https://git.qemu.org/?p=qemu.git;a=commitdiff;h=0065e915192cdf83c270

Just RTFM ;-)

 Thomas
