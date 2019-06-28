Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18908C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E9120828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E9120828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtey-0006CQ-3S
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35601)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1hgtOV-0003wZ-Mu
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1hgtOR-0002vZ-JG
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:06:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33380)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>)
 id 1hgtO8-0002Uz-86; Fri, 28 Jun 2019 12:06:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 470F230832C5;
 Fri, 28 Jun 2019 16:06:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-99.rdu2.redhat.com
 [10.10.123.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AFE31001B02;
 Fri, 28 Jun 2019 16:05:52 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190627212816.27298-1-jsnow@redhat.com>
 <20190627212816.27298-2-jsnow@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <6a208f32-6d0c-acbd-b5ea-ec12e618d6ba@redhat.com>
Date: Fri, 28 Jun 2019 13:05:48 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190627212816.27298-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 28 Jun 2019 16:06:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/3] python/qemu: split QEMUMachine
 out from underneath __init__.py
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 06/27/2019 06:28 PM, John Snow wrote:
> It's not obvious that something named __init__.py actually houses
> important code that isn't relevant to python packaging glue. Move the
> QEMUMachine and related error classes out into their own module.
>
> Adjust users to the new import location.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/qemu/__init__.py                   | 502 +--------------------
>   python/qemu/machine.py                    | 520 ++++++++++++++++++++++
>   python/qemu/qtest.py                      |   2 +-
>   scripts/device-crash-test                 |   2 +-
>   scripts/render_block_graph.py             |   2 +-
>   tests/acceptance/avocado_qemu/__init__.py |   2 +-
>   tests/acceptance/virtio_version.py        |   2 +-
>   tests/migration/guestperf/engine.py       |  22 +-
>   tests/qemu-iotests/235                    |   2 +-
>   tests/vm/basevm.py                        |   3 +-
>   10 files changed, 540 insertions(+), 519 deletions(-)
>   create mode 100644 python/qemu/machine.py
>
> diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
> index dbaf8a5311..6c919a3d56 100644
> --- a/python/qemu/__init__.py
> +++ b/python/qemu/__init__.py
> @@ -12,17 +12,11 @@
>   # Based on qmp.py.
>   #
>   
> -import errno
>   import logging
>   import os
> -import subprocess
> -import re
> -import shutil
> -import socket
> -import tempfile
>   
>   from . import qmp
> -
> +from . import machine
>   
>   LOG = logging.getLogger(__name__)
>   
> @@ -39,497 +33,3 @@ def kvm_available(target_arch=None):
>           if target_arch != ADDITIONAL_ARCHES.get(host_arch):
>               return False
>       return os.access("/dev/kvm", os.R_OK | os.W_OK)
> -
> -
> -class QEMUMachineError(Exception):
> -    """
> -    Exception called when an error in QEMUMachine happens.
> -    """
> -
> -
> -class QEMUMachineAddDeviceError(QEMUMachineError):
> -    """
> -    Exception raised when a request to add a device can not be fulfilled
> -
> -    The failures are caused by limitations, lack of information or conflicting
> -    requests on the QEMUMachine methods.  This exception does not represent
> -    failures reported by the QEMU binary itself.
> -    """
> -
> -class MonitorResponseError(qmp.QMPError):
> -    """
> -    Represents erroneous QMP monitor reply
> -    """
> -    def __init__(self, reply):
> -        try:
> -            desc = reply["error"]["desc"]
> -        except KeyError:
> -            desc = reply
> -        super(MonitorResponseError, self).__init__(desc)
> -        self.reply = reply
> -
> -
> -class QEMUMachine(object):
> -    """
> -    A QEMU VM
> -
> -    Use this object as a context manager to ensure the QEMU process terminates::
> -
> -        with VM(binary) as vm:
> -            ...
> -        # vm is guaranteed to be shut down here
> -    """
> -
> -    def __init__(self, binary, args=None, wrapper=None, name=None,
> -                 test_dir="/var/tmp", monitor_address=None,
> -                 socket_scm_helper=None):
> -        '''
> -        Initialize a QEMUMachine
> -
> -        @param binary: path to the qemu binary
> -        @param args: list of extra arguments
> -        @param wrapper: list of arguments used as prefix to qemu binary
> -        @param name: prefix for socket and log file names (default: qemu-PID)
> -        @param test_dir: where to create socket and log file
> -        @param monitor_address: address for QMP monitor
> -        @param socket_scm_helper: helper program, required for send_fd_scm()
> -        @note: Qemu process is not started until launch() is used.
> -        '''
> -        if args is None:
> -            args = []
> -        if wrapper is None:
> -            wrapper = []
> -        if name is None:
> -            name = "qemu-%d" % os.getpid()
> -        self._name = name
> -        self._monitor_address = monitor_address
> -        self._vm_monitor = None
> -        self._qemu_log_path = None
> -        self._qemu_log_file = None
> -        self._popen = None
> -        self._binary = binary
> -        self._args = list(args)     # Force copy args in case we modify them
> -        self._wrapper = wrapper
> -        self._events = []
> -        self._iolog = None
> -        self._socket_scm_helper = socket_scm_helper
> -        self._qmp = None
> -        self._qemu_full_args = None
> -        self._test_dir = test_dir
> -        self._temp_dir = None
> -        self._launched = False
> -        self._machine = None
> -        self._console_set = False
> -        self._console_device_type = None
> -        self._console_address = None
> -        self._console_socket = None
> -
> -        # just in case logging wasn't configured by the main script:
> -        logging.basicConfig()
> -
> -    def __enter__(self):
> -        return self
> -
> -    def __exit__(self, exc_type, exc_val, exc_tb):
> -        self.shutdown()
> -        return False
> -
> -    # This can be used to add an unused monitor instance.
> -    def add_monitor_null(self):
> -        self._args.append('-monitor')
> -        self._args.append('null')
> -
> -    def add_fd(self, fd, fdset, opaque, opts=''):
> -        """
> -        Pass a file descriptor to the VM
> -        """
> -        options = ['fd=%d' % fd,
> -                   'set=%d' % fdset,
> -                   'opaque=%s' % opaque]
> -        if opts:
> -            options.append(opts)
> -
> -        # This did not exist before 3.4, but since then it is
> -        # mandatory for our purpose
> -        if hasattr(os, 'set_inheritable'):
> -            os.set_inheritable(fd, True)
> -
> -        self._args.append('-add-fd')
> -        self._args.append(','.join(options))
> -        return self
> -
> -    # Exactly one of fd and file_path must be given.
> -    # (If it is file_path, the helper will open that file and pass its
> -    # own fd)
> -    def send_fd_scm(self, fd=None, file_path=None):
> -        # In iotest.py, the qmp should always use unix socket.
> -        assert self._qmp.is_scm_available()
> -        if self._socket_scm_helper is None:
> -            raise QEMUMachineError("No path to socket_scm_helper set")
> -        if not os.path.exists(self._socket_scm_helper):
> -            raise QEMUMachineError("%s does not exist" %
> -                                   self._socket_scm_helper)
> -
> -        # This did not exist before 3.4, but since then it is
> -        # mandatory for our purpose
> -        if hasattr(os, 'set_inheritable'):
> -            os.set_inheritable(self._qmp.get_sock_fd(), True)
> -            if fd is not None:
> -                os.set_inheritable(fd, True)
> -
> -        fd_param = ["%s" % self._socket_scm_helper,
> -                    "%d" % self._qmp.get_sock_fd()]
> -
> -        if file_path is not None:
> -            assert fd is None
> -            fd_param.append(file_path)
> -        else:
> -            assert fd is not None
> -            fd_param.append(str(fd))
> -
> -        devnull = open(os.path.devnull, 'rb')
> -        proc = subprocess.Popen(fd_param, stdin=devnull, stdout=subprocess.PIPE,
> -                                stderr=subprocess.STDOUT, close_fds=False)
> -        output = proc.communicate()[0]
> -        if output:
> -            LOG.debug(output)
> -
> -        return proc.returncode
> -
> -    @staticmethod
> -    def _remove_if_exists(path):
> -        """
> -        Remove file object at path if it exists
> -        """
> -        try:
> -            os.remove(path)
> -        except OSError as exception:
> -            if exception.errno == errno.ENOENT:
> -                return
> -            raise
> -
> -    def is_running(self):
> -        return self._popen is not None and self._popen.poll() is None
> -
> -    def exitcode(self):
> -        if self._popen is None:
> -            return None
> -        return self._popen.poll()
> -
> -    def get_pid(self):
> -        if not self.is_running():
> -            return None
> -        return self._popen.pid
> -
> -    def _load_io_log(self):
> -        if self._qemu_log_path is not None:
> -            with open(self._qemu_log_path, "r") as iolog:
> -                self._iolog = iolog.read()
> -
> -    def _base_args(self):
> -        if isinstance(self._monitor_address, tuple):
> -            moncdev = "socket,id=mon,host=%s,port=%s" % (
> -                self._monitor_address[0],
> -                self._monitor_address[1])
> -        else:
> -            moncdev = 'socket,id=mon,path=%s' % self._vm_monitor
> -        args = ['-chardev', moncdev,
> -                '-mon', 'chardev=mon,mode=control',
> -                '-display', 'none', '-vga', 'none']
> -        if self._machine is not None:
> -            args.extend(['-machine', self._machine])
> -        if self._console_set:
> -            self._console_address = os.path.join(self._temp_dir,
> -                                                 self._name + "-console.sock")
> -            chardev = ('socket,id=console,path=%s,server,nowait' %
> -                       self._console_address)
> -            args.extend(['-chardev', chardev])
> -            if self._console_device_type is None:
> -                args.extend(['-serial', 'chardev:console'])
> -            else:
> -                device = '%s,chardev=console' % self._console_device_type
> -                args.extend(['-device', device])
> -        return args
> -
> -    def _pre_launch(self):
> -        self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
> -        if self._monitor_address is not None:
> -            self._vm_monitor = self._monitor_address
> -        else:
> -            self._vm_monitor = os.path.join(self._temp_dir,
> -                                            self._name + "-monitor.sock")
> -        self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
> -        self._qemu_log_file = open(self._qemu_log_path, 'wb')
> -
> -        self._qmp = qmp.QEMUMonitorProtocol(self._vm_monitor,
> -                                            server=True)
> -
> -    def _post_launch(self):
> -        self._qmp.accept()
> -
> -    def _post_shutdown(self):
> -        if self._qemu_log_file is not None:
> -            self._qemu_log_file.close()
> -            self._qemu_log_file = None
> -
> -        self._qemu_log_path = None
> -
> -        if self._console_socket is not None:
> -            self._console_socket.close()
> -            self._console_socket = None
> -
> -        if self._temp_dir is not None:
> -            shutil.rmtree(self._temp_dir)
> -            self._temp_dir = None
> -
> -    def launch(self):
> -        """
> -        Launch the VM and make sure we cleanup and expose the
> -        command line/output in case of exception
> -        """
> -
> -        if self._launched:
> -            raise QEMUMachineError('VM already launched')
> -
> -        self._iolog = None
> -        self._qemu_full_args = None
> -        try:
> -            self._launch()
> -            self._launched = True
> -        except:
> -            self.shutdown()
> -
> -            LOG.debug('Error launching VM')
> -            if self._qemu_full_args:
> -                LOG.debug('Command: %r', ' '.join(self._qemu_full_args))
> -            if self._iolog:
> -                LOG.debug('Output: %r', self._iolog)
> -            raise
> -
> -    def _launch(self):
> -        """
> -        Launch the VM and establish a QMP connection
> -        """
> -        devnull = open(os.path.devnull, 'rb')
> -        self._pre_launch()
> -        self._qemu_full_args = (self._wrapper + [self._binary] +
> -                                self._base_args() + self._args)
> -        LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
> -        self._popen = subprocess.Popen(self._qemu_full_args,
> -                                       stdin=devnull,
> -                                       stdout=self._qemu_log_file,
> -                                       stderr=subprocess.STDOUT,
> -                                       shell=False,
> -                                       close_fds=False)
> -        self._post_launch()
> -
> -    def wait(self):
> -        """
> -        Wait for the VM to power off
> -        """
> -        self._popen.wait()
> -        self._qmp.close()
> -        self._load_io_log()
> -        self._post_shutdown()
> -
> -    def shutdown(self):
> -        """
> -        Terminate the VM and clean up
> -        """
> -        if self.is_running():
> -            try:
> -                self._qmp.cmd('quit')
> -                self._qmp.close()
> -            except:
> -                self._popen.kill()
> -            self._popen.wait()
> -
> -        self._load_io_log()
> -        self._post_shutdown()
> -
> -        exitcode = self.exitcode()
> -        if exitcode is not None and exitcode < 0:
> -            msg = 'qemu received signal %i: %s'
> -            if self._qemu_full_args:
> -                command = ' '.join(self._qemu_full_args)
> -            else:
> -                command = ''
> -            LOG.warn(msg, -exitcode, command)
> -
> -        self._launched = False
> -
> -    def qmp(self, cmd, conv_keys=True, **args):
> -        """
> -        Invoke a QMP command and return the response dict
> -        """
> -        qmp_args = dict()
> -        for key, value in args.items():
> -            if conv_keys:
> -                qmp_args[key.replace('_', '-')] = value
> -            else:
> -                qmp_args[key] = value
> -
> -        return self._qmp.cmd(cmd, args=qmp_args)
> -
> -    def command(self, cmd, conv_keys=True, **args):
> -        """
> -        Invoke a QMP command.
> -        On success return the response dict.
> -        On failure raise an exception.
> -        """
> -        reply = self.qmp(cmd, conv_keys, **args)
> -        if reply is None:
> -            raise qmp.QMPError("Monitor is closed")
> -        if "error" in reply:
> -            raise MonitorResponseError(reply)
> -        return reply["return"]
> -
> -    def get_qmp_event(self, wait=False):
> -        """
> -        Poll for one queued QMP events and return it
> -        """
> -        if len(self._events) > 0:
> -            return self._events.pop(0)
> -        return self._qmp.pull_event(wait=wait)
> -
> -    def get_qmp_events(self, wait=False):
> -        """
> -        Poll for queued QMP events and return a list of dicts
> -        """
> -        events = self._qmp.get_events(wait=wait)
> -        events.extend(self._events)
> -        del self._events[:]
> -        self._qmp.clear_events()
> -        return events
> -
> -    @staticmethod
> -    def event_match(event, match=None):
> -        """
> -        Check if an event matches optional match criteria.
> -
> -        The match criteria takes the form of a matching subdict. The event is
> -        checked to be a superset of the subdict, recursively, with matching
> -        values whenever the subdict values are not None.
> -
> -        This has a limitation that you cannot explicitly check for None values.
> -
> -        Examples, with the subdict queries on the left:
> -         - None matches any object.
> -         - {"foo": None} matches {"foo": {"bar": 1}}
> -         - {"foo": None} matches {"foo": 5}
> -         - {"foo": {"abc": None}} does not match {"foo": {"bar": 1}}
> -         - {"foo": {"rab": 2}} matches {"foo": {"bar": 1, "rab": 2}}
> -        """
> -        if match is None:
> -            return True
> -
> -        try:
> -            for key in match:
> -                if key in event:
> -                    if not QEMUMachine.event_match(event[key], match[key]):
> -                        return False
> -                else:
> -                    return False
> -            return True
> -        except TypeError:
> -            # either match or event wasn't iterable (not a dict)
> -            return match == event
> -
> -    def event_wait(self, name, timeout=60.0, match=None):
> -        """
> -        event_wait waits for and returns a named event from QMP with a timeout.
> -
> -        name: The event to wait for.
> -        timeout: QEMUMonitorProtocol.pull_event timeout parameter.
> -        match: Optional match criteria. See event_match for details.
> -        """
> -        return self.events_wait([(name, match)], timeout)
> -
> -    def events_wait(self, events, timeout=60.0):
> -        """
> -        events_wait waits for and returns a named event from QMP with a timeout.
> -
> -        events: a sequence of (name, match_criteria) tuples.
> -                The match criteria are optional and may be None.
> -                See event_match for details.
> -        timeout: QEMUMonitorProtocol.pull_event timeout parameter.
> -        """
> -        def _match(event):
> -            for name, match in events:
> -                if (event['event'] == name and
> -                    self.event_match(event, match)):
> -                    return True
> -            return False
> -
> -        # Search cached events
> -        for event in self._events:
> -            if _match(event):
> -                self._events.remove(event)
> -                return event
> -
> -        # Poll for new events
> -        while True:
> -            event = self._qmp.pull_event(wait=timeout)
> -            if _match(event):
> -                return event
> -            self._events.append(event)
> -
> -        return None
> -
> -    def get_log(self):
> -        """
> -        After self.shutdown or failed qemu execution, this returns the output
> -        of the qemu process.
> -        """
> -        return self._iolog
> -
> -    def add_args(self, *args):
> -        """
> -        Adds to the list of extra arguments to be given to the QEMU binary
> -        """
> -        self._args.extend(args)
> -
> -    def set_machine(self, machine_type):
> -        """
> -        Sets the machine type
> -
> -        If set, the machine type will be added to the base arguments
> -        of the resulting QEMU command line.
> -        """
> -        self._machine = machine_type
> -
> -    def set_console(self, device_type=None):
> -        """
> -        Sets the device type for a console device
> -
> -        If set, the console device and a backing character device will
> -        be added to the base arguments of the resulting QEMU command
> -        line.
> -
> -        This is a convenience method that will either use the provided
> -        device type, or default to a "-serial chardev:console" command
> -        line argument.
> -
> -        The actual setting of command line arguments will be be done at
> -        machine launch time, as it depends on the temporary directory
> -        to be created.
> -
> -        @param device_type: the device type, such as "isa-serial".  If
> -                            None is given (the default value) a "-serial
> -                            chardev:console" command line argument will
> -                            be used instead, resorting to the machine's
> -                            default device type.
> -        """
> -        self._console_set = True
> -        self._console_device_type = device_type
> -
> -    @property
> -    def console_socket(self):
> -        """
> -        Returns a socket connected to the console
> -        """
> -        if self._console_socket is None:
> -            self._console_socket = socket.socket(socket.AF_UNIX,
> -                                                 socket.SOCK_STREAM)
> -            self._console_socket.connect(self._console_address)
> -        return self._console_socket
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> new file mode 100644
> index 0000000000..a8a311b035
> --- /dev/null
> +++ b/python/qemu/machine.py
> @@ -0,0 +1,520 @@
> +# QEMU library
> +#
> +# Copyright (C) 2015-2016 Red Hat Inc.
> +# Copyright (C) 2012 IBM Corp.
> +#
> +# Authors:
> +#  Fam Zheng <famz@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.  See
> +# the COPYING file in the top-level directory.
> +#
> +# Based on qmp.py.
> +#
> +
> +import errno
> +import logging
> +import os
> +import subprocess
> +import re
> +import shutil
> +import socket
> +import tempfile
> +
> +from . import qmp
> +
> +LOG = logging.getLogger(__name__)
> +
> +class QEMUMachineError(Exception):
> +    """
> +    Exception called when an error in QEMUMachine happens.
> +    """
> +
> +
> +class QEMUMachineAddDeviceError(QEMUMachineError):
> +    """
> +    Exception raised when a request to add a device can not be fulfilled
> +
> +    The failures are caused by limitations, lack of information or conflicting
> +    requests on the QEMUMachine methods.  This exception does not represent
> +    failures reported by the QEMU binary itself.
> +    """
> +
> +
> +class MonitorResponseError(qmp.QMPError):
> +    """
> +    Represents erroneous QMP monitor reply
> +    """
> +    def __init__(self, reply):
> +        try:
> +            desc = reply["error"]["desc"]
> +        except KeyError:
> +            desc = reply
> +        super(MonitorResponseError, self).__init__(desc)
> +        self.reply = reply
> +
> +
> +class QEMUMachine(object):
> +    """
> +    A QEMU VM
> +
> +    Use this object as a context manager to ensure the QEMU process terminates::
> +
> +        with VM(binary) as vm:
> +            ...
> +        # vm is guaranteed to be shut down here
> +    """
> +
> +    def __init__(self, binary, args=None, wrapper=None, name=None,
> +                 test_dir="/var/tmp", monitor_address=None,
> +                 socket_scm_helper=None):
> +        '''
> +        Initialize a QEMUMachine
> +
> +        @param binary: path to the qemu binary
> +        @param args: list of extra arguments
> +        @param wrapper: list of arguments used as prefix to qemu binary
> +        @param name: prefix for socket and log file names (default: qemu-PID)
> +        @param test_dir: where to create socket and log file
> +        @param monitor_address: address for QMP monitor
> +        @param socket_scm_helper: helper program, required for send_fd_scm()
> +        @note: Qemu process is not started until launch() is used.
> +        '''
> +        if args is None:
> +            args = []
> +        if wrapper is None:
> +            wrapper = []
> +        if name is None:
> +            name = "qemu-%d" % os.getpid()
> +        self._name = name
> +        self._monitor_address = monitor_address
> +        self._vm_monitor = None
> +        self._qemu_log_path = None
> +        self._qemu_log_file = None
> +        self._popen = None
> +        self._binary = binary
> +        self._args = list(args)     # Force copy args in case we modify them
> +        self._wrapper = wrapper
> +        self._events = []
> +        self._iolog = None
> +        self._socket_scm_helper = socket_scm_helper
> +        self._qmp = None
> +        self._qemu_full_args = None
> +        self._test_dir = test_dir
> +        self._temp_dir = None
> +        self._launched = False
> +        self._machine = None
> +        self._console_set = False
> +        self._console_device_type = None
> +        self._console_address = None
> +        self._console_socket = None
> +
> +        # just in case logging wasn't configured by the main script:
> +        logging.basicConfig()
> +
> +    def __enter__(self):
> +        return self
> +
> +    def __exit__(self, exc_type, exc_val, exc_tb):
> +        self.shutdown()
> +        return False
> +
> +    # This can be used to add an unused monitor instance.
> +    def add_monitor_null(self):
> +        self._args.append('-monitor')
> +        self._args.append('null')
> +
> +    def add_fd(self, fd, fdset, opaque, opts=''):
> +        """
> +        Pass a file descriptor to the VM
> +        """
> +        options = ['fd=%d' % fd,
> +                   'set=%d' % fdset,
> +                   'opaque=%s' % opaque]
> +        if opts:
> +            options.append(opts)
> +
> +        # This did not exist before 3.4, but since then it is
> +        # mandatory for our purpose
> +        if hasattr(os, 'set_inheritable'):
> +            os.set_inheritable(fd, True)
> +
> +        self._args.append('-add-fd')
> +        self._args.append(','.join(options))
> +        return self
> +
> +    # Exactly one of fd and file_path must be given.
> +    # (If it is file_path, the helper will open that file and pass its
> +    # own fd)
> +    def send_fd_scm(self, fd=None, file_path=None):
> +        # In iotest.py, the qmp should always use unix socket.
> +        assert self._qmp.is_scm_available()
> +        if self._socket_scm_helper is None:
> +            raise QEMUMachineError("No path to socket_scm_helper set")
> +        if not os.path.exists(self._socket_scm_helper):
> +            raise QEMUMachineError("%s does not exist" %
> +                                   self._socket_scm_helper)
> +
> +        # This did not exist before 3.4, but since then it is
> +        # mandatory for our purpose
> +        if hasattr(os, 'set_inheritable'):
> +            os.set_inheritable(self._qmp.get_sock_fd(), True)
> +            if fd is not None:
> +                os.set_inheritable(fd, True)
> +
> +        fd_param = ["%s" % self._socket_scm_helper,
> +                    "%d" % self._qmp.get_sock_fd()]
> +
> +        if file_path is not None:
> +            assert fd is None
> +            fd_param.append(file_path)
> +        else:
> +            assert fd is not None
> +            fd_param.append(str(fd))
> +
> +        devnull = open(os.path.devnull, 'rb')
> +        proc = subprocess.Popen(fd_param, stdin=devnull, stdout=subprocess.PIPE,
> +                                stderr=subprocess.STDOUT, close_fds=False)
> +        output = proc.communicate()[0]
> +        if output:
> +            LOG.debug(output)
> +
> +        return proc.returncode
> +
> +    @staticmethod
> +    def _remove_if_exists(path):
> +        """
> +        Remove file object at path if it exists
> +        """
> +        try:
> +            os.remove(path)
> +        except OSError as exception:
> +            if exception.errno == errno.ENOENT:
> +                return
> +            raise
> +
> +    def is_running(self):
> +        return self._popen is not None and self._popen.poll() is None
> +
> +    def exitcode(self):
> +        if self._popen is None:
> +            return None
> +        return self._popen.poll()
> +
> +    def get_pid(self):
> +        if not self.is_running():
> +            return None
> +        return self._popen.pid
> +
> +    def _load_io_log(self):
> +        if self._qemu_log_path is not None:
> +            with open(self._qemu_log_path, "r") as iolog:
> +                self._iolog = iolog.read()
> +
> +    def _base_args(self):
> +        if isinstance(self._monitor_address, tuple):
> +            moncdev = "socket,id=mon,host=%s,port=%s" % (
> +                self._monitor_address[0],
> +                self._monitor_address[1])
> +        else:
> +            moncdev = 'socket,id=mon,path=%s' % self._vm_monitor
> +        args = ['-chardev', moncdev,
> +                '-mon', 'chardev=mon,mode=control',
> +                '-display', 'none', '-vga', 'none']
> +        if self._machine is not None:
> +            args.extend(['-machine', self._machine])
> +        if self._console_set:
> +            self._console_address = os.path.join(self._temp_dir,
> +                                                 self._name + "-console.sock")
> +            chardev = ('socket,id=console,path=%s,server,nowait' %
> +                       self._console_address)
> +            args.extend(['-chardev', chardev])
> +            if self._console_device_type is None:
> +                args.extend(['-serial', 'chardev:console'])
> +            else:
> +                device = '%s,chardev=console' % self._console_device_type
> +                args.extend(['-device', device])
> +        return args
> +
> +    def _pre_launch(self):
> +        self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
> +        if self._monitor_address is not None:
> +            self._vm_monitor = self._monitor_address
> +        else:
> +            self._vm_monitor = os.path.join(self._temp_dir,
> +                                            self._name + "-monitor.sock")
> +        self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
> +        self._qemu_log_file = open(self._qemu_log_path, 'wb')
> +
> +        self._qmp = qmp.QEMUMonitorProtocol(self._vm_monitor,
> +                                            server=True)
> +
> +    def _post_launch(self):
> +        self._qmp.accept()
> +
> +    def _post_shutdown(self):
> +        if self._qemu_log_file is not None:
> +            self._qemu_log_file.close()
> +            self._qemu_log_file = None
> +
> +        self._qemu_log_path = None
> +
> +        if self._console_socket is not None:
> +            self._console_socket.close()
> +            self._console_socket = None
> +
> +        if self._temp_dir is not None:
> +            shutil.rmtree(self._temp_dir)
> +            self._temp_dir = None
> +
> +    def launch(self):
> +        """
> +        Launch the VM and make sure we cleanup and expose the
> +        command line/output in case of exception
> +        """
> +
> +        if self._launched:
> +            raise QEMUMachineError('VM already launched')
> +
> +        self._iolog = None
> +        self._qemu_full_args = None
> +        try:
> +            self._launch()
> +            self._launched = True
> +        except:
> +            self.shutdown()
> +
> +            LOG.debug('Error launching VM')
> +            if self._qemu_full_args:
> +                LOG.debug('Command: %r', ' '.join(self._qemu_full_args))
> +            if self._iolog:
> +                LOG.debug('Output: %r', self._iolog)
> +            raise
> +
> +    def _launch(self):
> +        """
> +        Launch the VM and establish a QMP connection
> +        """
> +        devnull = open(os.path.devnull, 'rb')
> +        self._pre_launch()
> +        self._qemu_full_args = (self._wrapper + [self._binary] +
> +                                self._base_args() + self._args)
> +        LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
> +        self._popen = subprocess.Popen(self._qemu_full_args,
> +                                       stdin=devnull,
> +                                       stdout=self._qemu_log_file,
> +                                       stderr=subprocess.STDOUT,
> +                                       shell=False,
> +                                       close_fds=False)
> +        self._post_launch()
> +
> +    def wait(self):
> +        """
> +        Wait for the VM to power off
> +        """
> +        self._popen.wait()
> +        self._qmp.close()
> +        self._load_io_log()
> +        self._post_shutdown()
> +
> +    def shutdown(self):
> +        """
> +        Terminate the VM and clean up
> +        """
> +        if self.is_running():
> +            try:
> +                self._qmp.cmd('quit')
> +                self._qmp.close()
> +            except:
> +                self._popen.kill()
> +            self._popen.wait()
> +
> +        self._load_io_log()
> +        self._post_shutdown()
> +
> +        exitcode = self.exitcode()
> +        if exitcode is not None and exitcode < 0:
> +            msg = 'qemu received signal %i: %s'
> +            if self._qemu_full_args:
> +                command = ' '.join(self._qemu_full_args)
> +            else:
> +                command = ''
> +            LOG.warn(msg, -exitcode, command)
> +
> +        self._launched = False
> +
> +    def qmp(self, cmd, conv_keys=True, **args):
> +        """
> +        Invoke a QMP command and return the response dict
> +        """
> +        qmp_args = dict()
> +        for key, value in args.items():
> +            if conv_keys:
> +                qmp_args[key.replace('_', '-')] = value
> +            else:
> +                qmp_args[key] = value
> +
> +        return self._qmp.cmd(cmd, args=qmp_args)
> +
> +    def command(self, cmd, conv_keys=True, **args):
> +        """
> +        Invoke a QMP command.
> +        On success return the response dict.
> +        On failure raise an exception.
> +        """
> +        reply = self.qmp(cmd, conv_keys, **args)
> +        if reply is None:
> +            raise qmp.QMPError("Monitor is closed")
> +        if "error" in reply:
> +            raise MonitorResponseError(reply)
> +        return reply["return"]
> +
> +    def get_qmp_event(self, wait=False):
> +        """
> +        Poll for one queued QMP events and return it
> +        """
> +        if len(self._events) > 0:
> +            return self._events.pop(0)
> +        return self._qmp.pull_event(wait=wait)
> +
> +    def get_qmp_events(self, wait=False):
> +        """
> +        Poll for queued QMP events and return a list of dicts
> +        """
> +        events = self._qmp.get_events(wait=wait)
> +        events.extend(self._events)
> +        del self._events[:]
> +        self._qmp.clear_events()
> +        return events
> +
> +    @staticmethod
> +    def event_match(event, match=None):
> +        """
> +        Check if an event matches optional match criteria.
> +
> +        The match criteria takes the form of a matching subdict. The event is
> +        checked to be a superset of the subdict, recursively, with matching
> +        values whenever the subdict values are not None.
> +
> +        This has a limitation that you cannot explicitly check for None values.
> +
> +        Examples, with the subdict queries on the left:
> +         - None matches any object.
> +         - {"foo": None} matches {"foo": {"bar": 1}}
> +         - {"foo": None} matches {"foo": 5}
> +         - {"foo": {"abc": None}} does not match {"foo": {"bar": 1}}
> +         - {"foo": {"rab": 2}} matches {"foo": {"bar": 1, "rab": 2}}
> +        """
> +        if match is None:
> +            return True
> +
> +        try:
> +            for key in match:
> +                if key in event:
> +                    if not QEMUMachine.event_match(event[key], match[key]):
> +                        return False
> +                else:
> +                    return False
> +            return True
> +        except TypeError:
> +            # either match or event wasn't iterable (not a dict)
> +            return match == event
> +
> +    def event_wait(self, name, timeout=60.0, match=None):
> +        """
> +        event_wait waits for and returns a named event from QMP with a timeout.
> +
> +        name: The event to wait for.
> +        timeout: QEMUMonitorProtocol.pull_event timeout parameter.
> +        match: Optional match criteria. See event_match for details.
> +        """
> +        return self.events_wait([(name, match)], timeout)
> +
> +    def events_wait(self, events, timeout=60.0):
> +        """
> +        events_wait waits for and returns a named event from QMP with a timeout.
> +
> +        events: a sequence of (name, match_criteria) tuples.
> +                The match criteria are optional and may be None.
> +                See event_match for details.
> +        timeout: QEMUMonitorProtocol.pull_event timeout parameter.
> +        """
> +        def _match(event):
> +            for name, match in events:
> +                if (event['event'] == name and
> +                    self.event_match(event, match)):
> +                    return True
> +            return False
> +
> +        # Search cached events
> +        for event in self._events:
> +            if _match(event):
> +                self._events.remove(event)
> +                return event
> +
> +        # Poll for new events
> +        while True:
> +            event = self._qmp.pull_event(wait=timeout)
> +            if _match(event):
> +                return event
> +            self._events.append(event)
> +
> +        return None
> +
> +    def get_log(self):
> +        """
> +        After self.shutdown or failed qemu execution, this returns the output
> +        of the qemu process.
> +        """
> +        return self._iolog
> +
> +    def add_args(self, *args):
> +        """
> +        Adds to the list of extra arguments to be given to the QEMU binary
> +        """
> +        self._args.extend(args)
> +
> +    def set_machine(self, machine_type):
> +        """
> +        Sets the machine type
> +
> +        If set, the machine type will be added to the base arguments
> +        of the resulting QEMU command line.
> +        """
> +        self._machine = machine_type
> +
> +    def set_console(self, device_type=None):
> +        """
> +        Sets the device type for a console device
> +
> +        If set, the console device and a backing character device will
> +        be added to the base arguments of the resulting QEMU command
> +        line.
> +
> +        This is a convenience method that will either use the provided
> +        device type, or default to a "-serial chardev:console" command
> +        line argument.
> +
> +        The actual setting of command line arguments will be be done at
> +        machine launch time, as it depends on the temporary directory
> +        to be created.
> +
> +        @param device_type: the device type, such as "isa-serial".  If
> +                            None is given (the default value) a "-serial
> +                            chardev:console" command line argument will
> +                            be used instead, resorting to the machine's
> +                            default device type.
> +        """
> +        self._console_set = True
> +        self._console_device_type = device_type
> +
> +    @property
> +    def console_socket(self):
> +        """
> +        Returns a socket connected to the console
> +        """
> +        if self._console_socket is None:
> +            self._console_socket = socket.socket(socket.AF_UNIX,
> +                                                 socket.SOCK_STREAM)
> +            self._console_socket.connect(self._console_address)
> +        return self._console_socket
> diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
> index eb45824dd0..eebcc233ed 100644
> --- a/python/qemu/qtest.py
> +++ b/python/qemu/qtest.py
> @@ -14,7 +14,7 @@
>   import socket
>   import os
>   
> -from . import QEMUMachine
> +from .machine import QEMUMachine
>   
>   
>   class QEMUQtestProtocol(object):
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index a6748910ad..15f213a6cd 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -36,7 +36,7 @@ import argparse
>   from itertools import chain
>   
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
> -from qemu import QEMUMachine
> +from qemu.machine import QEMUMachine
>   
>   logger = logging.getLogger('device-crash-test')
>   dbg = logger.debug
> diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
> index 3e9d282a49..656f0388ad 100755
> --- a/scripts/render_block_graph.py
> +++ b/scripts/render_block_graph.py
> @@ -25,7 +25,7 @@ import json
>   from graphviz import Digraph
>   
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
> -from qemu import MonitorResponseError
> +from qemu.machine import MonitorResponseError
>   
>   
>   def perm(arr):
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index 2b236a1cf0..aee5d820ed 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -17,7 +17,7 @@ import avocado
>   SRC_ROOT_DIR = os.path.join(os.path.dirname(__file__), '..', '..', '..')
>   sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
>   
> -from qemu import QEMUMachine
> +from qemu.machine import QEMUMachine
>   
>   def is_readable_executable_file(path):
>       return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
> diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio_version.py
> index 8b97453ff8..33593c29dd 100644
> --- a/tests/acceptance/virtio_version.py
> +++ b/tests/acceptance/virtio_version.py
> @@ -12,7 +12,7 @@ import sys
>   import os
>   
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
> -from qemu import QEMUMachine
> +from qemu.machine import QEMUMachine
>   from avocado_qemu import Test
>   
>   # Virtio Device IDs:
> diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
> index 0e304660b8..f13dbea800 100644
> --- a/tests/migration/guestperf/engine.py
> +++ b/tests/migration/guestperf/engine.py
> @@ -30,7 +30,7 @@ from guestperf.timings import TimingRecord, Timings
>   
>   sys.path.append(os.path.join(os.path.dirname(__file__),
>                                '..', '..', '..', 'python'))
> -import qemu
> +from qemu.machine import QEMUMachine
>   
>   
>   class Engine(object):
> @@ -386,17 +386,17 @@ class Engine(object):
>               dstmonaddr = "/var/tmp/qemu-dst-%d-monitor.sock" % os.getpid()
>           srcmonaddr = "/var/tmp/qemu-src-%d-monitor.sock" % os.getpid()
>   
> -        src = qemu.QEMUMachine(self._binary,
> -                               args=self._get_src_args(hardware),
> -                               wrapper=self._get_src_wrapper(hardware),
> -                               name="qemu-src-%d" % os.getpid(),
> -                               monitor_address=srcmonaddr)
> +        src = QEMUMachine(self._binary,
> +                          args=self._get_src_args(hardware),
> +                          wrapper=self._get_src_wrapper(hardware),
> +                          name="qemu-src-%d" % os.getpid(),
> +                          monitor_address=srcmonaddr)
>   
> -        dst = qemu.QEMUMachine(self._binary,
> -                               args=self._get_dst_args(hardware, uri),
> -                               wrapper=self._get_dst_wrapper(hardware),
> -                               name="qemu-dst-%d" % os.getpid(),
> -                               monitor_address=dstmonaddr)
> +        dst = QEMUMachine(self._binary,
> +                          args=self._get_dst_args(hardware, uri),
> +                          wrapper=self._get_dst_wrapper(hardware),
> +                          name="qemu-dst-%d" % os.getpid(),
> +                          monitor_address=dstmonaddr)
>   
>           try:
>               src.launch()
> diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
> index 2b6a8c13be..fedd111fd4 100755
> --- a/tests/qemu-iotests/235
> +++ b/tests/qemu-iotests/235
> @@ -25,7 +25,7 @@ from iotests import qemu_img_create, qemu_io, file_path, log
>   
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
>   
> -from qemu import QEMUMachine
> +from qemu.machine import QEMUMachine
>   
>   # Note:
>   # This test was added to check that mirror dead-lock was fixed (see previous
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 0556bdcf9e..4b496f1551 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -18,7 +18,8 @@ import logging
>   import time
>   import datetime
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
> -from qemu import QEMUMachine, kvm_available
> +from qemu import kvm_available

Perhaps kvm_available deserves another house as well.

In '[PATCH 2/3] tests/acceptance: Introduce the "accel" tag' I created 
the avocado_qemu.accel module to host code related with accelerators and 
use on acceptance tests. So maybe I should create that module actually 
in qemu and then put kvm_available there. What do you think?

- Wainer


> +from qemu.machine import QEMUMachine
>   import subprocess
>   import hashlib
>   import optparse


