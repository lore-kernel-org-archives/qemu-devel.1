Received: from eggs.gnu.org ([209.51.188.92]:36526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hFApa-0004YI-CX
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hFApZ-0006KW-40
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:03:58 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190412152619.23542-1-thuth@redhat.com>
	<CAFEAcA9kXdUH3vkGLfEe+CFuD=S9XFEaWGNETre7gYOx5epFpQ@mail.gmail.com>
	<7d2fc749-e6ac-7646-8e37-3399d42b6822@redhat.com>
Date: Sat, 13 Apr 2019 07:03:52 +0200
In-Reply-To: <7d2fc749-e6ac-7646-8e37-3399d42b6822@redhat.com> (Thomas Huth's
	message of "Fri, 12 Apr 2019 20:59:12 +0200")
Message-ID: <87sgumh4xz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/arm/nseries: Deprecate the n800
 and n810 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Thomas Huth <thuth@redhat.com> writes:

> On 12/04/2019 18.02, Peter Maydell wrote:
>> On Fri, 12 Apr 2019 at 16:26, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> These machines depend on the deprecated bluetooth subsystem. In case we
>>> finally decide to remove the bluetooth subsystem, we likely need to
>>> remove the n800 and n810 machines, too, so mark them now as deprecated.
>> 
>> ...we could just remove the bluetooth devices from the boards?
>
> Maybe we could. But do we really want to spent time to work on boards
> that likely nobody uses anymore? Or do you know anybody using it?
> (at least Guenter does not seem to use it, according to his list, see
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06125.html )

I think we're far too willing to drag along code of dubious utility.

Deprecation is not a death sentence.  It's a formal notice to users "we
intend to drop this, and now is the time to argue for keeping it".
