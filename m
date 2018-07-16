Received: from eggs.gnu.org ([2001:4830:134:3::10]:58070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff3na-0002dR-45
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff3nZ-00081r-9M
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:44:22 -0400
References: <1531415537-26037-1-git-send-email-thuth@redhat.com>
	<CAFEAcA9_TrSTrcHBGS1mAd0-w2VSQ0AP3z=EPM_U3dTF3k_R1w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7ea6a810-1216-b45d-3c25-9d843769b051@redhat.com>
Date: Mon, 16 Jul 2018 15:44:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9_TrSTrcHBGS1mAd0-w2VSQ0AP3z=EPM_U3dTF3k_R1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm2836: Mark the bcm2836 / bcm2837
 devices with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 16.07.2018 15:39, Peter Maydell wrote:
> On 12 July 2018 at 18:12, Thomas Huth <thuth@redhat.com> wrote:
>> These devices are currently causing some problems when a user is trying
>> to hot-plug or introspect them during runtime. Since these devices can
>> not be instantiated by the user at all (they need to be wired up in code
>> instead), we should mark them with user_creatable = false anyway, then we
>> avoid at least the crashes with the hot-plugging. The introspection problem
>> will be handled by a separate patch.
> 
> I thought we'd changed things so all sysbus devices defaulted
> to not-user-createable? Am I confusing that with something else?
> (The set of user-creatable sysbus devices must be very small...)

You remember it right, but TYPE_BCM283X is not a sysbus device, it is
declared with ".parent = TYPE_DEVICE" instead.

 Thomas
