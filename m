Received: from eggs.gnu.org ([2001:4830:134:3::10]:34846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1emyDt-0006bV-8O
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 03:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1emyDo-000436-DO
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 03:51:57 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180216121810.56ed961e.cohuck@redhat.com>
	<CAFEAcA8nRr6OgJ0OAgk6xL2dXQVrUMod5kMzPufykjVNj-yNug@mail.gmail.com>
	<8b721785-5581-8936-2517-1fa00db3dabd@redhat.com>
	<CAFEAcA82O0HpZCa_sHJmwn7sH4HYE4NUAg0ni_Z2n_+d4JMAWQ@mail.gmail.com>
	<4a71adf2-f617-74c2-cf7e-34517ac6aade@redhat.com>
	<20180216170904.5933125f.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19e61baf-0efe-5ff4-5070-3953191ae6e3@redhat.com>
Date: Sat, 17 Feb 2018 09:51:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180216170904.5933125f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Process] QEMU submaintainers and pull requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 16/02/2018 17:09, Cornelia Huck wrote:
>> BTW, Fam and I are also planning to improve Patchew so that it is better
>> at detecting pull requests and especially merged pull requests.
> 
> Cool.
> 
> Would a certain formatting be helpful for patchew as well? Or do you
> plan to parse the cover letter to hopefully find the output of git
> request-pull and get the correct base from that?

Yes, basically replace "git am" with "git fetch" if the cover letter has
a line that looks like it's produced by "git request-pull".

Paolo
