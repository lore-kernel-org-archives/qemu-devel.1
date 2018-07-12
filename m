Received: from eggs.gnu.org ([2001:4830:134:3::10]:60525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdUbu-00031F-3Y
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 01:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdUbt-0004TY-CE
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 01:57:50 -0400
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<ca91bffe-2bcf-78a2-02cd-8ae7cc48074c@redhat.com>
	<163e1c54-c953-e5fe-3142-eab18e0362b8@redhat.com>
	<016ebe6a-91e3-24f3-9e2a-26613bd9f61e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <993eb8a8-dab7-693b-d5bd-988138c9cad1@redhat.com>
Date: Thu, 12 Jul 2018 07:57:39 +0200
MIME-Version: 1.0
In-Reply-To: <016ebe6a-91e3-24f3-9e2a-26613bd9f61e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm283x: Fix crash with device_add
 bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 11.07.2018 22:15, Paolo Bonzini wrote:
[...]
> I think you're on the right track, after object_property_add_child you
> need to drop the reference to the object.

Yes, that's the issue indeed! The child objects get properly cleaned up
once I add the object_unref() after the object_property_add_child(), and
then the crash does not occur anymore. I'll check the other spots, then
I'll write a patch...

 Thomas
