Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0FFC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88656247C5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcRhQvZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88656247C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnLY-0002sC-Cz
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXnGb-0004ZJ-TJ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXnGY-0006j6-4N
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603898493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4TRBKZWBUBDcKsVHBSGNq8jyJohG7UgNpkZmnJCwQI=;
 b=YcRhQvZWraPnQsPuCslaM9JNvmVgbERyoAoSH0aPpEGlnkck0+t8pqzO6aJxlmpA9aVUav
 MCCgGGuKF5kZdCVJZ76TtTyUgRDPJXIscsohQMHhpmvjXL5tdNncNcU0WfO8g2XBiHNBlM
 qCoZAyLqyg7ZadnPRwZhyirnoPZTc5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-3ryISMmmMV-dciXx_0TD3g-1; Wed, 28 Oct 2020 11:21:27 -0400
X-MC-Unique: 3ryISMmmMV-dciXx_0TD3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43CD1EC10B;
 Wed, 28 Oct 2020 15:21:26 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C06845D9EF;
 Wed, 28 Oct 2020 15:21:19 +0000 (UTC)
Subject: Re: [PATCH v3 01/15] python: create qemu packages
To: Cleber Rosa <crosa@redhat.com>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-2-jsnow@redhat.com>
 <20201028144616.GB2201333@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <1a05a456-2739-f539-0072-01ac7074f53b@redhat.com>
Date: Wed, 28 Oct 2020 11:21:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028144616.GB2201333@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ben Widawsky <ben@bwidawsk.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 10:46 AM, Cleber Rosa wrote:
> On Tue, Oct 20, 2020 at 03:35:41PM -0400, John Snow wrote:
>> move python/qemu/*.py to python/qemu/[machine, qmp]/*.py and update import
>> directives across the tree.
>>
>> This is done to create a PEP420 namespace package, in which we may
>> create subpackages. To do this, the namespace directory ("qemu") should
>> not have any modules in it. Those files will go into new 'machine' and 'qmp'
>> subpackages instead.
>>
>> Implement machine/__init__.py making the top-level classes and functions
>> from its various modules available directly inside the package. Change
>> qmp.py to qmp/__init__.py similarly, such that all of the useful QMP
>> library classes are available directly from "qemu.qmp" instead of
>> "qemu.qmp.qmp".
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   python/{qemu => }/.isort.cfg                |  0
>>   python/qemu/__init__.py                     | 11 ------
>>   python/qemu/{ => machine}/.flake8           |  0
>>   python/qemu/machine/__init__.py             | 41 +++++++++++++++++++++
>>   python/qemu/{ => machine}/accel.py          |  0
>>   python/qemu/{ => machine}/console_socket.py |  0
>>   python/qemu/{ => machine}/machine.py        | 16 +++++---
>>   python/qemu/{ => machine}/pylintrc          |  0
>>   python/qemu/{ => machine}/qtest.py          |  3 +-
>>   python/qemu/{qmp.py => qmp/__init__.py}     | 12 +++++-
>>   tests/acceptance/boot_linux.py              |  3 +-
>>   tests/qemu-iotests/297                      |  2 +-
>>   tests/qemu-iotests/300                      |  4 +-
>>   tests/qemu-iotests/iotests.py               |  2 +-
>>   tests/vm/basevm.py                          |  3 +-
>>   15 files changed, 71 insertions(+), 26 deletions(-)
>>   rename python/{qemu => }/.isort.cfg (100%)
>>   delete mode 100644 python/qemu/__init__.py
>>   rename python/qemu/{ => machine}/.flake8 (100%)
>>   create mode 100644 python/qemu/machine/__init__.py
>>   rename python/qemu/{ => machine}/accel.py (100%)
>>   rename python/qemu/{ => machine}/console_socket.py (100%)
>>   rename python/qemu/{ => machine}/machine.py (98%)
>>   rename python/qemu/{ => machine}/pylintrc (100%)
>>   rename python/qemu/{ => machine}/qtest.py (99%)
>>   rename python/qemu/{qmp.py => qmp/__init__.py} (96%)
>>
>> diff --git a/python/qemu/.isort.cfg b/python/.isort.cfg
>> similarity index 100%
>> rename from python/qemu/.isort.cfg
>> rename to python/.isort.cfg
>> diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
>> deleted file mode 100644
>> index 4ca06c34a4..0000000000
>> --- a/python/qemu/__init__.py
>> +++ /dev/null
>> @@ -1,11 +0,0 @@
>> -# QEMU library
>> -#
>> -# Copyright (C) 2015-2016 Red Hat Inc.
>> -# Copyright (C) 2012 IBM Corp.
>> -#
>> -# Authors:
>> -#  Fam Zheng <famz@redhat.com>
>> -#
>> -# This work is licensed under the terms of the GNU GPL, version 2.  See
>> -# the COPYING file in the top-level directory.
>> -#
>> diff --git a/python/qemu/.flake8 b/python/qemu/machine/.flake8
>> similarity index 100%
>> rename from python/qemu/.flake8
>> rename to python/qemu/machine/.flake8
>> diff --git a/python/qemu/machine/__init__.py b/python/qemu/machine/__init__.py
>> new file mode 100644
>> index 0000000000..27b0b19abd
>> --- /dev/null
>> +++ b/python/qemu/machine/__init__.py
>> @@ -0,0 +1,41 @@
>> +"""
>> +QEMU development and testing library.
>> +
>> +This library provides a few high-level classes for driving QEMU from a
>> +test suite, not intended for production use.
>> +
>> +- QEMUMachine: Configure and Boot a QEMU VM
>> + - QEMUQtestMachine: VM class, with a qtest socket.
>> +
>> +- QEMUQtestProtocol: Connect to, send/receive qtest messages.
>> +
>> +- list_accel: List available accelerators
>> +- kvm_available: Probe for KVM support
>> +- tcg_available: Probe for TCG support
>> +"""
>> +
>> +# Copyright (C) 2020 John Snow for Red Hat Inc.
>> +# Copyright (C) 2015-2016 Red Hat Inc.
>> +# Copyright (C) 2012 IBM Corp.
>> +#
>> +# Authors:
>> +#  John Snow <jsnow@redhat.com>
>> +#  Fam Zheng <fam@euphon.net>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2.  See
>> +# the COPYING file in the top-level directory.
>> +#
>> +
>> +from .accel import kvm_available, list_accel, tcg_available
>> +from .machine import QEMUMachine
>> +from .qtest import QEMUQtestMachine, QEMUQtestProtocol
>> +
>> +
>> +__all__ = (
>> +    'list_accel',
>> +    'kvm_available',
>> +    'tcg_available',
>> +    'QEMUMachine',
>> +    'QEMUQtestProtocol',
>> +    'QEMUQtestMachine',
>> +)
> 
> How far would this approach go?  I mean, should all future APIs be developed
> inside module under "qemu/machine", say "qemu/machine/foo.py" and their main
> functionality imported here?  Or do you see this as a temporary state?
> 

I assume any new functionality can be directly imported. Having this 
here doesn't prevent using the fully qualified module names.

i.e. you can still do "from qemu.machine.machine import QEMUMachine".

Offering root-level aliases seems like a very prevalent paradigm in 
popular third-party packages like 'requests'. Not justification in and 
of itself, but there's precedent.

> IMO, this is hard to maintain, and is a very easy path to future
> inconsistencies.
> 

Maybe. The alternative is to do what I did to QMP and stick it back 
inside of __init__.

What I don't like is:

from qemu.machine.machine import QEMUMachine

I prefer:

from qemu.machine import QEMUMachine


Of course, I also like help(qemu.machine) to show something useful, 
which is going to generally involve updating the docstring to explain 
what the major APIs here are anyway, so I think actually you cannot 
escape your fate of having to keep a list of APIs updated in a 
multi-module package.

Maybe you could make an argument that keeping both the docstring and the 
__all__ attribute in sync is an undue maintenance burden, but I'd need 
some more convincing.

>> diff --git a/python/qemu/accel.py b/python/qemu/machine/accel.py
>> similarity index 100%
>> rename from python/qemu/accel.py
>> rename to python/qemu/machine/accel.py
>> diff --git a/python/qemu/console_socket.py b/python/qemu/machine/console_socket.py
>> similarity index 100%
>> rename from python/qemu/console_socket.py
>> rename to python/qemu/machine/console_socket.py
>> diff --git a/python/qemu/machine.py b/python/qemu/machine/machine.py
>> similarity index 98%
>> rename from python/qemu/machine.py
>> rename to python/qemu/machine/machine.py
>> index 6420f01bed..a5dc305539 100644
>> --- a/python/qemu/machine.py
>> +++ b/python/qemu/machine/machine.py
>> @@ -38,8 +38,14 @@
>>       Type,
>>   )
>>   
>> -from . import console_socket, qmp
>> -from .qmp import QMPMessage, QMPReturnValue, SocketAddrT
>> +from qemu.qmp import (
>> +    QEMUMonitorProtocol,
>> +    QMPMessage,
>> +    QMPReturnValue,
>> +    SocketAddrT,
>> +)
>> +
>> +from . import console_socket
>>   
>>   
>>   LOG = logging.getLogger(__name__)
>> @@ -139,7 +145,7 @@ def __init__(self,
>>           self._events: List[QMPMessage] = []
>>           self._iolog: Optional[str] = None
>>           self._qmp_set = True   # Enable QMP monitor by default.
>> -        self._qmp_connection: Optional[qmp.QEMUMonitorProtocol] = None
>> +        self._qmp_connection: Optional[QEMUMonitorProtocol] = None
>>           self._qemu_full_args: Tuple[str, ...] = ()
>>           self._temp_dir: Optional[str] = None
>>           self._launched = False
>> @@ -314,7 +320,7 @@ def _pre_launch(self) -> None:
>>               if self._remove_monitor_sockfile:
>>                   assert isinstance(self._monitor_address, str)
>>                   self._remove_files.append(self._monitor_address)
>> -            self._qmp_connection = qmp.QEMUMonitorProtocol(
>> +            self._qmp_connection = QEMUMonitorProtocol(
>>                   self._monitor_address,
>>                   server=True,
>>                   nickname=self._name
>> @@ -534,7 +540,7 @@ def set_qmp_monitor(self, enabled: bool = True) -> None:
>>           self._qmp_set = enabled
>>   
>>       @property
>> -    def _qmp(self) -> qmp.QEMUMonitorProtocol:
>> +    def _qmp(self) -> QEMUMonitorProtocol:
>>           if self._qmp_connection is None:
>>               raise QEMUMachineError("Attempt to access QMP with no connection")
>>           return self._qmp_connection
>> diff --git a/python/qemu/pylintrc b/python/qemu/machine/pylintrc
>> similarity index 100%
>> rename from python/qemu/pylintrc
>> rename to python/qemu/machine/pylintrc
>> diff --git a/python/qemu/qtest.py b/python/qemu/machine/qtest.py
>> similarity index 99%
>> rename from python/qemu/qtest.py
>> rename to python/qemu/machine/qtest.py
>> index 39a0cf62fe..53926e434a 100644
>> --- a/python/qemu/qtest.py
>> +++ b/python/qemu/machine/qtest.py
>> @@ -26,8 +26,9 @@
>>       TextIO,
>>   )
>>   
>> +from qemu.qmp import SocketAddrT
>> +
>>   from .machine import QEMUMachine
>> -from .qmp import SocketAddrT
>>   
>>   
>>   class QEMUQtestProtocol:
>> diff --git a/python/qemu/qmp.py b/python/qemu/qmp/__init__.py
>> similarity index 96%
>> rename from python/qemu/qmp.py
>> rename to python/qemu/qmp/__init__.py
>> index 2cd4d43036..9606248a3d 100644
>> --- a/python/qemu/qmp.py
>> +++ b/python/qemu/qmp/__init__.py
>> @@ -1,4 +1,14 @@
>> -""" QEMU Monitor Protocol Python class """
>> +"""
>> +QEMU Monitor Protocol (QMP) development library & tooling.
>> +
>> +This package provides a fairly low-level class for communicating to QMP
>> +protocol servers, as implemented by QEMU, the QEMU Guest Agent, and the
>> +QEMU Storage Daemon. This library is not intended for production use.
>> +
>> +`QEMUMonitorProtocol` is the primary class of interest, and all errors
>> +raised derive from `QMPError`.
>> +"""
>> +
>>   # Copyright (C) 2009, 2010 Red Hat Inc.
>>   #
>>   # Authors:
>> diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
>> index 0055dc7cee..54f999e647 100644
>> --- a/tests/acceptance/boot_linux.py
>> +++ b/tests/acceptance/boot_linux.py
>> @@ -12,8 +12,7 @@
>>   
>>   from avocado_qemu import Test, BUILD_DIR
>>   
>> -from qemu.accel import kvm_available
>> -from qemu.accel import tcg_available
>> +from qemu.machine import kvm_available, tcg_available
>>
> 
> I think this reveals a slight downgrade of the API caused by the usage
> of the symbols from "qemu.machine" namespace.
> 
> My point is that there are valid use cases for using "kvm_available"
> without using a "QEMUMachine".  This presuposes that "qemu.machine" is
> named like that because "QEMUMachine" are the main actors of this
> namespace.
> 

No, the accel functions literally start a QEMU process and probe its 
output to determine what they support. This belongs directly alongside 
the machine code in my opinion.

(I also don't know why'd you call these functions unless you intended to 
create a machine based on what you found.


I see your point that it is not a method of the Machine class itself nor 
an extension thereof; but I think for the purpose of three small helper 
functions it's not worth creating an entirely new package to contain.

Nor is it worth watering down the "machine" name to something less 
specific to accommodate three tiny helper functions.

If I am considering "machine" the "package that knows how to start and 
interact with QEMU", then accel belongs here.

> Naming is hard, (so don't assume I believe "utils" below is the best
> or even a good name), but I'd be more confortable using an API along
> the lines:
> 
>     from qemu.utils.accel import kvm_available
>     kvm_available()
> 
> OR
> 
>     from qemu.utils import accel
>     accel.kvm_available()
> 

utils/tools I am reserving as a package for various debugging scripts 
and tools in the future that I don't intend to upload to PyPI, e.g. many 
of the "thematically loose" scripts in ./scripts.

> This would also remove the need to keep importing symbols into the
> current "qemu.machine" namespace.
> 

It would, but it's three functions. It doesn't warrant an entire package 
for a single module with three standalone functions.

That calculus may change in the future if we accumulate lots more 
miscellaneous thingies to make that more worthwhile!

>>   from avocado.utils import cloudinit
>>   from avocado.utils import network
>> diff --git a/tests/qemu-iotests/297 b/tests/qemu-iotests/297
>> index 5c5420712b..8236875222 100755
>> --- a/tests/qemu-iotests/297
>> +++ b/tests/qemu-iotests/297
>> @@ -36,7 +36,7 @@ MYPYPATH=../../python/ mypy --warn-unused-configs --disallow-subclassing-any \
>>       --disallow-any-generics --disallow-incomplete-defs \
>>       --disallow-untyped-decorators --no-implicit-optional \
>>       --warn-redundant-casts --warn-unused-ignores \
>> -    --no-implicit-reexport iotests.py
>> +    --no-implicit-reexport --namespace-packages iotests.py
>>   
>>   # success, all done
>>   echo "*** done"
>> diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
>> index 5b75121b84..a41fac4e1d 100755
>> --- a/tests/qemu-iotests/300
>> +++ b/tests/qemu-iotests/300
>> @@ -23,7 +23,7 @@ import random
>>   import re
>>   from typing import Dict, List, Optional, Union
>>   import iotests
>> -import qemu
>> +from qemu.machine import machine
>>
> 
> I believe this gives my previous comment some extra strength.  I think
> this shows that "qemu.machine" containing "machine" really means that
> the first "machine" naming component doesn't really mean that.
> 

Yeah, I don't like the duplication of 'machine' here either. I believe 
this test needs access to specific error classes which I didn't believe 
were important enough to receive an alias.

Might be that the correct thing to do is to stick machine.py in 
machine/__init__.py to avoid that duplication, just like I did with qmp.py.

> "qemu.utils" is not perfect, but it's much more honest IMO.
> 
> Cheers,
> - Cleber.
> 
>>   BlockBitmapMapping = List[Dict[str, Union[str, List[Dict[str, str]]]]]
>>   
>> @@ -454,7 +454,7 @@ class TestBlockBitmapMappingErrors(TestDirtyBitmapMigration):
>>           # the failed migration
>>           try:
>>               self.vm_b.shutdown()
>> -        except qemu.machine.AbnormalShutdown:
>> +        except machine.AbnormalShutdown:
>>               pass
>>   
>>       def test_aliased_bitmap_name_too_long(self) -> None:
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
>> index 63d2ace93c..6574afd735 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -37,7 +37,7 @@
>>   
>>   # pylint: disable=import-error, wrong-import-position
>>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
>> -from qemu import qtest
>> +from qemu.machine import qtest
>>   from qemu.qmp import QMPMessage
>>   
>>   # Use this logger for logging messages directly from the iotests module
>> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
>> index 3fac20e929..b38969f61f 100644
>> --- a/tests/vm/basevm.py
>> +++ b/tests/vm/basevm.py
>> @@ -19,8 +19,7 @@
>>   import time
>>   import datetime
>>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
>> -from qemu.accel import kvm_available
>> -from qemu.machine import QEMUMachine
>> +from qemu.machine import kvm_available, QEMUMachine
>>   import subprocess
>>   import hashlib
>>   import argparse
>> -- 
>> 2.26.2
>>


