Received: from eggs.gnu.org ([2001:4830:134:3::10]:58178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9bSL-000692-Vt
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9bSK-0005mg-Fz
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:44:41 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-10-crosa@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b590e7a3-c0e8-f39b-8a9b-b56d4804a6bc@redhat.com>
Date: Mon, 8 Oct 2018 15:44:14 -0400
MIME-Version: 1.0
In-Reply-To: <20181004161852.11673-10-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 09/10] scripts/qemu.py: use a
 more consistent docstring style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>



On 10/04/2018 12:18 PM, Cleber Rosa wrote:
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  dtc             |  2 +-
>  scripts/qemu.py | 65 +++++++++++++++++++++++++++++++------------------
>  2 files changed, 42 insertions(+), 25 deletions(-)
> 
> diff --git a/dtc b/dtc
> index 88f18909db..e54388015a 160000
> --- a/dtc
> +++ b/dtc
> @@ -1 +1 @@
> -Subproject commit 88f18909db731a627456f26d779445f84e449536
> +Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index f099ce7278..7abe26de69 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -53,9 +53,9 @@ class QEMUMachineAddDeviceError(QEMUMachineError):
>      """
>  
>  class MonitorResponseError(qmp.qmp.QMPError):
> -    '''
> +    """
>      Represents erroneous QMP monitor reply
> -    '''
> +    """

This seems obviously correct, as per the Python Dogma Handbook ...

>      def __init__(self, reply):
>          try:
>              desc = reply["error"]["desc"]
> @@ -66,14 +66,15 @@ class MonitorResponseError(qmp.qmp.QMPError):
>  
>  
>  class QEMUMachine(object):
> -    '''A QEMU VM
> +    """
> +    A QEMU VM
>  
>      Use this object as a context manager to ensure the QEMU process terminates::
>  
>          with VM(binary) as vm:
>              ...
>          # vm is guaranteed to be shut down here
> -    '''
> +    """

As does this,,

>  
>      def __init__(self, binary, args=None, wrapper=None, name=None,
>                   test_dir="/var/tmp", monitor_address=None,
> @@ -135,7 +136,9 @@ class QEMUMachine(object):
>          self._args.append(args)
>  
>      def add_fd(self, fd, fdset, opaque, opts=''):
> -        '''Pass a file descriptor to the VM'''
> +        """
> +        Pass a file descriptor to the VM
> +        """

However, is it established practice among ne'er-do-wells to format
one-line docstrings as three-liners? (And without punctuation to boot --
for shame!)

PEP257 suggests that one-liners are allowed, but doesn't seem to
necessitate their usage. Does this kind of change have any kind of benefit?

>          options = ['fd=%d' % fd,
>                     'set=%d' % fdset,
>                     'opaque=%s' % opaque]
> @@ -168,7 +171,9 @@ class QEMUMachine(object):
>  
>      @staticmethod
>      def _remove_if_exists(path):
> -        '''Remove file object at path if it exists'''
> +        """
> +        Remove file object at path if it exists
> +        """
>          try:
>              os.remove(path)
>          except OSError as exception:
> @@ -271,7 +276,9 @@ class QEMUMachine(object):
>              raise
>  
>      def _launch(self):
> -        '''Launch the VM and establish a QMP connection'''
> +        """
> +        Launch the VM and establish a QMP connection
> +        """
>          devnull = open(os.path.devnull, 'rb')
>          self._pre_launch()
>          self._qemu_full_args = (self._wrapper + [self._binary] +
> @@ -284,14 +291,18 @@ class QEMUMachine(object):
>          self._post_launch()
>  
>      def wait(self):
> -        '''Wait for the VM to power off'''
> +        """
> +        Wait for the VM to power off
> +        """
>          self._popen.wait()
>          self._qmp.close()
>          self._load_io_log()
>          self._post_shutdown()
>  
>      def shutdown(self):
> -        '''Terminate the VM and clean up'''
> +        """
> +        Terminate the VM and clean up
> +        """
>          if self.is_running():
>              try:
>                  self._qmp.cmd('quit')
> @@ -315,7 +326,9 @@ class QEMUMachine(object):
>          self._launched = False
>  
>      def qmp(self, cmd, conv_keys=True, **args):
> -        '''Invoke a QMP command and return the response dict'''
> +        """
> +        Invoke a QMP command and return the response dict
> +        """
>          qmp_args = dict()
>          for key, value in args.items():
>              if conv_keys:
> @@ -326,11 +339,11 @@ class QEMUMachine(object):
>          return self._qmp.cmd(cmd, args=qmp_args)
>  
>      def command(self, cmd, conv_keys=True, **args):
> -        '''
> +        """
>          Invoke a QMP command.
>          On success return the response dict.
>          On failure raise an exception.
> -        '''
> +        """
>          reply = self.qmp(cmd, conv_keys, **args)
>          if reply is None:
>              raise qmp.qmp.QMPError("Monitor is closed")
> @@ -339,13 +352,17 @@ class QEMUMachine(object):
>          return reply["return"]
>  
>      def get_qmp_event(self, wait=False):
> -        '''Poll for one queued QMP events and return it'''
> +        """
> +        Poll for one queued QMP events and return it
> +        """
>          if len(self._events) > 0:
>              return self._events.pop(0)
>          return self._qmp.pull_event(wait=wait)
>  
>      def get_qmp_events(self, wait=False):
> -        '''Poll for queued QMP events and return a list of dicts'''
> +        """
> +        Poll for queued QMP events and return a list of dicts
> +        """
>          events = self._qmp.get_events(wait=wait)
>          events.extend(self._events)
>          del self._events[:]
> @@ -353,7 +370,7 @@ class QEMUMachine(object):
>          return events
>  
>      def event_wait(self, name, timeout=60.0, match=None):
> -        '''
> +        """
>          Wait for specified timeout on named event in QMP; optionally filter
>          results by match.
>  
> @@ -361,7 +378,7 @@ class QEMUMachine(object):
>          branch processing on match's value None
>             {"foo": {"bar": 1}} matches {"foo": None}
>             {"foo": {"bar": 1}} does not matches {"foo": {"baz": None}}
> -        '''
> +        """
>          def event_match(event, match=None):
>              if match is None:
>                  return True
> @@ -394,29 +411,29 @@ class QEMUMachine(object):
>          return None
>  
>      def get_log(self):
> -        '''
> +        """
>          After self.shutdown or failed qemu execution, this returns the output
>          of the qemu process.
> -        '''
> +        """
>          return self._iolog
>  
>      def add_args(self, *args):
> -        '''
> +        """
>          Adds to the list of extra arguments to be given to the QEMU binary
> -        '''
> +        """
>          self._args.extend(args)
>  
>      def set_machine(self, machine_type):
> -        '''
> +        """
>          Sets the machine type
>  
>          If set, the machine type will be added to the base arguments
>          of the resulting QEMU command line.
> -        '''
> +        """
>          self._machine = machine_type
>  
>      def set_console(self, device_type=None):
> -        '''
> +        """
>          Sets the device type for a console device
>  
>          If set, the console device and a backing character device will
> @@ -434,7 +451,7 @@ class QEMUMachine(object):
>          @param device_type: the device type, such as "isa-serial"
>          @raises: QEMUMachineAddDeviceError if the device type is not given
>                   and can not be determined.
> -        '''
> +        """
>          if device_type is None:
>              if self._machine is None:
>                  raise QEMUMachineAddDeviceError("Can not add a console device:"
> 
